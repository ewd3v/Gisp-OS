local internetProxy = component.proxy(component.list("internet"))
assert(internetProxy, "Internet component is required.")

local code = ""
local handle, chunk = internetProxy.request()

while true do
  chunk = handle.read(math.huge)
  if not chunk then
    break
  end
  
  code = code..chunk
end

local result, errorMessage = load(code, "=installer")
if not result then
  error(errorMessage)
end

local runSucceed, runErrorMessage = xpcall(result, debug.traceback)
if not runSucceed then
  error(runErrorMessage)
end
