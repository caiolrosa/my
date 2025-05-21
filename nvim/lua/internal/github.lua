local M = {}

M.config = {
  org_issue_sync_file = nil,
}

M.setup = function(opts)
  M.config = vim.tbl_deep_extend("force", M.config, opts)
end

M.sync_issues = function()
  local curl = require("plenary.curl")
  local orgapi = require("orgmode.api")

  local since_date = "2025-01-01"
  local res = curl.get(string.format("https://api.github.com/issues?pulls=false&since=%s", since_date), {
    headers = {
      ["Accept"] = "application/vnd.github+json",
      ["X-GitHub-Api-Version"] = "2022-11-28",
      ["Authorization"] = "Bearer " .. os.getenv("GITHUB_TOKEN"),
    },
  })

  if res.status ~= 200 then
    return print("Failed pulling github issues")
  end

  local issues = vim.fn.json_decode(res.body)

  local file = io.open(M.config.org_issue_sync_file, "a+")
  if file == nil then
    return print("Failed to issue sync org file")
  end

  local orgfile = orgapi.load(M.config.org_issue_sync_file)

  for _, issue in pairs(issues) do
    local exists = headline_exists(orgfile.headlines, tostring(issue.id))
    if not exists then
      local headline = [=[
* TODO %s
  :PROPERTIES:
  :ID: %s
  :GITHUB_API_URL: %s
  :END:

  [[%s][Github Link]]

]=]
      file:write(string.format(headline, issue.title, issue.id, issue.html_url, issue.html_url))
    end
  end

  file:close()

  print("Finished github issue sync")
end

function headline_exists(headlines, id)
  if headlines == nil or next(headlines) == nil then
    return false
  end

  for _, headline in pairs(headlines) do
    local headline_id = headline:get_property("id")
    if headline_id ~= nil and headline_id == id then
      return true
    end

    headline_exists(headline.headlines, id)
  end

  return false
end

return M
