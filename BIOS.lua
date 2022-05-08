local component = require("component")
local internetProxy = component.proxy(component.list("internet")())
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
local codeResult = ""
local handle = internetProxy.request("https://raw.githubusercontent.com/Ew-Developer/Gisp-OS/main/Installer.lua")
print("Downloaded installer!")

for chunk in handle do
  codeResult = codeResult..chunk
end

if fileMode then
  local file = io.open("GispInstaller.lua", "w")
  file:write(codeResult)
  file:close()

  print("Installed installer on 'GispInstaller.lua'!")
  return
end

local result, errorMessage = load(codeResult, "=installer")
if not result then
  error(errorMessage)
end

local runSucceed, runErrorMessage = xpcall(result, debug.traceback)
if not runSucceed then
  error(runErrorMessage)
end