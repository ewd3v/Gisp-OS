local component = require("component")
local internetProxy = component.proxy(component.list("internet"))
assert(internetProxy, "Internet component is required.")

local fileMode = false
while true do
  print("Download the installer onto a file? [Y/N]")

  local option = io.read(1):lower()
  if option == "y" then
    fileMode = true
    break
  elseif option == "n" then
    fileMode = false
    break
  end
end

print("Downloading installer...")
local code = ""
local handle, chunk = internetProxy.request("https://raw.githubusercontent.com/Ew-Developer/Gisp-OS/main/Installer.lua")
print("Downloaded installer!")

while true do
  chunk = handle.read(math.huge)
  if not chunk then
    break
  end
  
  code = code..chunk
end

if fileMode then
  local file = io.open("GispInstaller.lua", "w")
  file:write(code)
  file:close()

  print("Installed installer on 'GispInstaller.lua'!")
  return
end

local result, errorMessage = load(code, "=installer")
if not result then
  error(errorMessage)
end

local runSucceed, runErrorMessage = xpcall(result, debug.traceback)
if not runSucceed then
  error(runErrorMessage)
end