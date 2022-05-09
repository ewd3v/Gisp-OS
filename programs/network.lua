os.execute("clear")
local event = require("event")
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
os.execute("clear")
print("Want to write messages? [y/n]")
local option = io.read()
if option == "y" then
  print("Select a username")
  local name = io.read()
  os.execute("clear")
  while true do
    local _, _, _, _, _, message = event.pull("modem_message")
    print(tostring(message))
    local message = io.read()
  if not modem.broadcast(69, name .. ": " .. message) then
    print("Failed to send the message")
    end
    os.sleep(3)
  end
end
print("Want to only collect data from network? [y/n]")
local option = io.read()
if option == "y" then
  while true do
    local _, _, _, _, _, message = event.pull("modem_message")
    print(tostring(message))
    end
  end
