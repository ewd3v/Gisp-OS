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
  os.execute("clear")
  local own_ip = component.modem.address
    print("This servers ip is: " .. own_ip)
  while(true) do
    local _, _, ip, _, _, message = event.pull("modem_message")
    if message == "Server? Do you exsist?" then
    print("Responding to search from: " .. ip)
    if modem.send(ip, 420, "Yes I exsist") then
      print("Responded to search!")
      local _, _, ip2, _, _, message = event.pull("modem_message")
        if ip2 == ip then
        local raw_file = message
        local internet = require("internet")
        assert(internet, "You are fucking stupid")
        local handle = internet.request(raw_file)
        local result = ""
        for chunk in handle do result = result..chunk end
        if modem.send(ip, 420, result) then
          print("Sent the file")
          else
          print("Failed to send the file")
        end
      else
        print("Failed to responde to: " .. ip)
          end
        end
      end
    end
  end


  else
    os.execute("clear")
    print("Searching for server")
      if modem.broadcast(420, "Server? Do you exsist?") then
        while(true) do
        local _, _, ip, _, _, exsist = event.pull("modem_message")
          if exsist == "Yes I exsist" then
            os.execute("clear")
            print("Found a server")
            print("Enter your download request (Input your link)")
            local link = io.read()
            if modem.send(ip, 420, link) then
              os.execute("clear")
              print("Sent your request, waiting for server to send your file!")
              local _, _, ip2, _, _, file = event.pull("modem_message")
            if ip2 == ip then
              print("Choose file format (.lua is the most common)")
              local format = io.read()
              local f = io.open("RENAME_DOWNLOADED_FILE.lua","w")
              f:write(file)
              f:close()
            end
          end
            else
              os.execute("clear")
              print("Failed to send request :/")
            end
          end
      else
        print("Failed to search for servers")
      end
end

