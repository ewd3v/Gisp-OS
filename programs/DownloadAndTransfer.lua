os.execute("clear")
local event = require("event")
local component = require("component")
local modem = component.modem
assert(modem, "You are fucking stupid")
if not modem.isOpen(420) then
  print("Do you want to open port 420? [y/n]")
  local option = io.read():lower()
  if option == "y" then
    print("Opening port 420")
    modem.open(420)
  end
end
if not modem.isOpen(420) then
  return
end

print("Port 420 is open!")
os.sleep(1)
os.execute("clear")
print("Is this the downloading server? [y/n]")
local option = io.read()
if option == "y" then
  while true do
    local own_ip = component.modem.address
    print("This servers ip is:" .. own_ip)
    local _, _, ip, _, _, message = event.pull("modem_message")
    print("Got a request from: " .. ip)
      local raw_file = message
      local internet = require("internet")
      local handle = internet.request(raw_file)
      local result = ""
      for chunk in handle do result = result..chunk end
      if modem.send(ip, 420, result) then
        print("Sent the file")
        else
        print("Failed to send the file")
      end
  end
  else
    print("enter the servers ip")
      local server_ip = io.read()
    print("Enter your download request (Input your link)")
      local link = io.read()
    modem.send(server_ip, 420, link)
  end
