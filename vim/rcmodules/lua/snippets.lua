-- Minimal snippet engine over mysnippets/*.snippets (UltiSnips plain-text
-- format subset: `snippet trigger ["desc"]` / body lines / `endsnippet`).
-- Expands via Neovim's built-in vim.snippet (LSP snippet syntax): supports
-- $1 / ${1:default} tabstops and this engine's own ${VISUAL:default}.

-- Custom minimal snippet engine over mysnippets/*.snippets, using Neovim's
-- built-in vim.snippet (LSP snippet syntax). Replaces UltiSnips, which is
-- disabled for now (see ultisnips.vim) — implementation in lua/snippets.lua.

-- mysnippets/ sits next to rcmodules/, derive its path from this file's own
-- location instead of hardcoding the dotfiles repo path.
local this_file = debug.getinfo(1, 'S').source:sub(2)
local snippets_dir = vim.fn.fnamemodify(this_file, ':h:h:h') .. '/mysnippets'
local cache = {}
local last_visual = nil

local function parse_file(path)
  local list, trigger, desc, body_lines = {}, nil, nil, nil
  for line in io.lines(path) do
    if line:match('^snippet%s') then
      trigger, desc = line:match('^snippet%s+(%S+)%s*"?([^"]*)"?%s*$')
      body_lines = {}
    elseif line == 'endsnippet' then
      if trigger then
        table.insert(list, { trigger = trigger, desc = desc, body = table.concat(body_lines, '\n') })
      end
      trigger = nil
    elseif trigger then
      table.insert(body_lines, line)
    end
  end
  return list
end

local function load_filetype(ft)
  if cache[ft] then return cache[ft] end
  local list = {}
  for _, name in ipairs({ 'all', ft }) do
    local path = snippets_dir .. '/' .. name .. '.snippets'
    if vim.fn.filereadable(path) == 1 then
      vim.list_extend(list, parse_file(path))
    end
  end
  cache[ft] = list
  return list
end

local function find_snippet(ft, trigger)
  for _, s in ipairs(load_filetype(ft)) do
    if s.trigger == trigger then return s end
  end
end

-- Resolve this engine's own ${VISUAL:default} (not an LSP/vim.snippet
-- construct) against a visual-selection text (nil/'' falls back to default).
local function substitute_visual(body, text)
  return (body:gsub('%${VISUAL:?([^}]*)}', function(default)
    return (text and text ~= '') and text or default
  end))
end

-- One-shot consume of the last visual selection remembered via the
-- xnoremap <C-k> mapping below.
local function consume_visual()
  local text = last_visual
  last_visual = nil
  return text
end

local function trigger_before_cursor()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  return line:sub(1, col):match('([%w_%.%-]+)$')
end

local function expand_at_cursor()
  local trigger = trigger_before_cursor()
  if not trigger then return false end
  local snip = find_snippet(vim.bo.filetype, trigger)
  if not snip then return false end
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_text(0, row - 1, col - #trigger, row - 1, col, { '' })
  vim.snippet.expand(substitute_visual(snip.body, consume_visual()))
  return true
end

-- Trigger keys (match the old UltiSnips ones: expand-or-jump-backward on
-- <C-k>, jump-forward on <C-j>).
vim.keymap.set({ 'i', 's' }, '<C-k>', function()
  if vim.snippet.active({ direction = -1 }) then
    vim.snippet.jump(-1)
  elseif vim.fn.mode() == 'i' then
    expand_at_cursor()
  end
end)

vim.keymap.set({ 'i', 's' }, '<C-j>', function()
  if vim.snippet.active({ direction = 1 }) then
    vim.snippet.jump(1)
  end
end)

-- Select text in visual mode, hit <C-k>: text is consumed and available as
-- ${VISUAL:default} in the next snippet expanded at the cursor.
vim.keymap.set('x', '<C-k>', function()
  vim.cmd('normal! "vy')
  last_visual = vim.fn.getreg('v')
  vim.cmd('normal! gvd')
  vim.cmd('startinsert')
end)

vim.api.nvim_create_user_command('SnippetsReload', function()
  cache = {}
end, {})

local ok, cmp = pcall(require, 'cmp')
if ok then
  local source = {}
  function source.new() return setmetatable({}, { __index = source }) end
  function source:is_available() return true end
  function source:get_debug_name() return 'my_snippets' end
  function source:complete(_, callback)
    local items = {}
    local visual = consume_visual()
    for _, s in ipairs(load_filetype(vim.bo.filetype)) do
      table.insert(items, {
        label = s.trigger,
        insertText = substitute_visual(s.body, visual),
        insertTextFormat = cmp.lsp.InsertTextFormat.Snippet,
        kind = cmp.lsp.CompletionItemKind.Snippet,
        detail = s.desc,
      })
    end
    callback(items)
  end
  cmp.register_source('my_snippets', source.new())
end
