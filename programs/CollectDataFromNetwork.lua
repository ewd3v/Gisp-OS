local component = require("component")
local modem = component.modem
assert(modem, "You are fucking stupid")
if not modem.isOpen(69) then
  print("Do you want to open port 69? [y/n]")
  local option = io.read():lower()
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

os.sleep(1)
print("Want to look for messages? [y/n]")
local option = io.read()
if option == "y" then
  while true do
  local _, _, from, port, _, message = event.pull("modem_message")
print("Got a message from " .. from .. " on port " .. port .. ": " .. tostring(message))
  end
end 
