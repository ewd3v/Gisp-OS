local component = require("component")
local modem = component.modem
assert(modem, "You are fucking stupid")
if not modem.isOpen(69) then
  print("Do you want to open port 69?")
  local option = io.read(1):lower()
  if option == "y" then
    print("Opening port 69")
    modem.open(69)
  else
    return
  end
end
if not modem.isOpen(69) then
  return
end

print("Port 69 is open!")

local input = io.read()