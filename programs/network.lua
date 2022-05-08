local component = require("component")
local modem = component.modem
assert(modem, "You are fucking stupid")
if not modem.isOpen(69) then
  print("Do you want to open port 69? [y/n]")
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
os.sleep(1)
print("Want to send a test message every 5 second? [y/n]")
if option == "y" then
  while true do
  if broadcast(69, "TEST") then
    print("Sent the message")
    else
    print("Failed to send the message")
    end
    os.sleep(5)
  end
end 
