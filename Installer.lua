local component = require("component")

function getComponent(name)
    return component[name] or error(string.format("%s component is required for Gisp-OS.", name))
end

local EEPROM, internet, GPU = getComponent("eeprom"), getComponent("internet"), getComponent("gpu")