local component = require("component")

function noComponentError(name)
    return error(string.format("The '%s' component is required for GispOS.", name))
end
function getComponent(name)
    return component[name] or noComponentError(name)
end

local eeprom, gpu = getComponent("eeprom"), getComponent("gpu")
local internet = require("internet") or noComponentError("internet")

local repositoryURL = "https://raw.githubusercontent.com/Ew-Developer/Gisp-OS/main"
local installerURL = repositoryURL.."/Installer"

gpu.bind(component.list("screen")() or noComponentError("screen"))
local screenWidth, screenHeight = gpu.getResolution()
local temporaryFilesystemProxy, selectedFilesystemProxy

function centrize(width)
    return math.floor(screenWidth / 2 - width / 2 + 0.5)
end
function centrizedText(y, color, text)
    gpu.fill(1, y, screenWidth, 1, " ")
	gpu.setForeground(color)
	gpu.set(centrize(#text), y, text)
end
function title()
    local y = math.floor(screenHeight / 2 - 1)
	centrizedText(y, 0x2D2D2D, "GispOS")

	return y + 2
end
function status(text, needWait)
	centrizedText(title(), 0x878787, text)

	if needWait then
		repeat
			needWait = computer.pullSignal()
		until needWait == "key_down" or needWait == "touch"
	end
end
function progress(value)
	local width = 26
	local x, y, part = centrize(width), title(), math.floor(width * value + 0.5)
	
	gpu.setForeground(0x878787)
	gpu.set(x, y, string.rep("─", part))
	gpu.setForeground(0xC3C3C3)
	gpu.set(x + part, y, string.rep("─", width - part))
end

gpu.setBackground(0xE1E1E1)
gpu.fill(1, 1, screenWidth, screenHeight, " ")

status("Finding suitable hard disk drive...", false)
for address in component.list("filesystem") do
	local proxy = component.proxy(address)
	if proxy.spaceTotal() >= 2 * 1024 * 1024 then
		temporaryFilesystemProxy, selectedFilesystemProxy = proxy, proxy
		break
	end
end

if not temporaryFilesystemProxy then
	status("No appropriate filesystem found", true)
	return
end