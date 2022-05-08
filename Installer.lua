local component = require("component")

function getComponent(name)
    return component[name] or error(string.format("%s component is required for Gisp-OS.", name))
end

local EEPROM, GPU = getComponent("eeprom"), getComponent("gpu")
local internet = require("internet")
assert(internet, "Internet component is required for Gisp-OS.")