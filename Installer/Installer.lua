local computer = require("computer")
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
local temporaryHDD, selectedHDD

function exit()
	return computer.shutdown(true)
end
function centrize(width)
    return math.floor(screenWidth / 2 - width / 2 + 0.5)
end
function centrizedText(y, text)
    gpu.fill(1, y, screenWidth, 1, " ")
	gpu.setForeground(0xFFFFFF)
	gpu.set(centrize(#text), y, text)
end
function title()
    local y = math.floor(screenHeight / 2 - 1)
	centrizedText(y, "GispOS")

	return y + 2
end
function status(text, needWait)
	local y = title()
	centrizedText(y, text)

	if needWait then
		centrizedText(y + 1, "(Click or press any key to continue...)")

		repeat
			needWait = computer.pullSignal()
		until needWait == "key_down" or needWait == "touch"
	end
end
function progress(value)
	local width = 26
	local x, y, part = centrize(width), title(), math.floor(width * value + 0.5)
	
	gpu.setForeground(0xFFFFFF)
	gpu.set(x, y, string.rep("─", part))
	--[[gpu.setForeground(0xC3C3C3)
	gpu.set(x + part, y, string.rep("─", width - part))]]
end

gpu.setBackground(0x000000)
gpu.fill(1, 1, screenWidth, screenHeight, " ")

status("Finding suitable hard disk drive...", false)
for address in component.list("filesystem") do
	local proxy = component.proxy(address)
	if proxy.spaceTotal() >=  then
		temporaryHDD, selectedHDD = proxy, proxy
		break
	end
end

if not temporaryHDD then
	status("No suitable hard disk drive found", true)
	return exit()
end
status("Found suitable hard disk drive found!", true)