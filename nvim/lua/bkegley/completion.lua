local vim = vim
--local completion = require'completion'
--local matching = require'completion.matching'
--local option = require'completion.option'
--local json = require'bkegley.json'

vim.g.completion_matching_strategy_list = {'substring', 'exact', 'fuzzy', 'all'}
vim.g.diagnostic_enable_virtual_text = 1
vim.g.diagnostic_insert_delay = 1
vim.g.completion_chain_complete_list = {
  {complete_items = {'lsp', 'snippet'}},
  {mode = '<c-p>'},
  {mode = '<c-n>'},
}

--local M = {}

--local parse_json = function()
  --local file = assert(io.open('./nvim/lua/bkegley/data.json'))
  --local json_data
  --if file then
    --json_data = json.decode(file:read("all"))
    --file:close()
  --end
  --return json_data
--end

--local build_completion_items = function()
  --local data = parse_json()
  --local words = {}
  --for _,v in pairs(data.data.__schema.types) do
    --table.insert(words, {word = v.name, kind = v.kind})
  --end
  --print(vim.inspect(words))
  --return words
--end

--local get_completion_items = function(prefix)
  --local complete_items = {}
  --local words = build_completion_items()
  --for _, word in pairs(words) do
    --if word.word ~= prefix then
      --matching.matching(complete_items, prefix, {
        --word = word.word,
        --kind = word.kind,
        --icase = 1,
        --dup = 1,
        --empty = 1,
      --})
    --end
  --end
  --return complete_items
--end

--local hostname = 'http://localhost:3000/graphql'

--M.update_graphql_host = function(updated_hostname)
  --hostname = updated_hostname
--end

--M.open_explorer = function()
  --vim.cmd(':vnew')
  --vim.cmd(':set filetype=gqlexplorer')
  --local chain_complete_list = {}

  --local explorer_complete_list = {
    --gqlexplorer = {complete_items = {'graphql'}}
  --}

  --local current_chain_complete_list = option.get_option('chain_complete_list')

  --if chain_complete_list.default then
    --chain_complete_list = vim.tbl_extend('error', current_chain_complete_list, explorer_complete_list)
  --else
    --local temp_chain_complete_list = {default = current_chain_complete_list}
    --chain_complete_list = vim.tbl_extend('error', temp_chain_complete_list, explorer_complete_list)
  --end

  --vim.g.completion_chain_complete_list = chain_complete_list
  --print(vim.inspect(vim.g.completion_chain_complete_list))
--end

--M.add_completion_sources = function()
  --print('hostname: ' .. hostname)
  --completion.addCompletionSource('graphql', {item = get_completion_items})
--end

--return M

