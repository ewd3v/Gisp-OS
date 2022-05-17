local computer = require("computer")
local com = require("component")
local net = com.modem
assert(net, "You are trying to do networking and you dont even have a network card")
if not net.isOpen(69) then
  net.open(69)
end
os.execute("clear")
print("Sending thru da intranet")
os.sleep(1)
local total = computer.totalMemory()
 if net.broadcast(69, "Total memory:") then
    print("Total memory:")
    else
    print("The data was not sent")
    end
if net.broadcast(69, total.." Byte") then
    print(total.." Byte")
    else
    print("The data was not sent")
    end
if net.broadcast(69, total/1024 .." KiloByte") then
    print(total/1024 .." KiloByte")
    else
    print("The data was not sent")
    end
if net.broadcast(69, total/1048576 .." MegaByte\n") then
    print(total/1048576 .." MegaByte\n")
    else
    print("The data was not sent")
    end

os.sleep(1)
local free = computer.freeMemory()
if net.broadcast(69, "Free memory:") then
    print("Free memory:")
    else
    print("The data was not sent")
    end
 if net.broadcast(69, free.." Byte") then
    print(free.." Byte")
    else
    print("The data was not sent")
    end
  if net.broadcast(69, free/1024 .." KiloByte") then
    print(free/1024 .." KiloByte")
    else
    print("The data was not sent")
    end
   if net.broadcast(69, free/1048576 .." MegaByte\n") then
    print(free/1048576 .." MegaByte\n")
    else
    print("The data was not sent")
    end

os.sleep(1)
 if net.broadcast(69, "Memory used:") then
    print("Memory used:")
    else
    print("The data was not sent")
    end
  if net.broadcast(69, string.format("%i%% memory is used", math.floor((1-(free/total))*100 + 0.5))) then
    print(string.format("%i%% memory is used", math.floor((1-(free/total))*100 + 0.5)))
    else
    print("The data was not sent")
    end
  if net.broadcast(69, total-free .." Byte") then
    print(total-free .." Byte")
    else
    print("The data was not sent")
    end
   if net.broadcast(69, (total-free)/1024 .." KiloByte") then
    print((total-free)/1024 .." KiloByte")
    else
    print("The data was not sent")
    end
  if net.broadcast(69, (total-free)/1048576 .." MegaByte") then
    print((total-free)/1048576 .." MegaByte")
    else
    print("The data was not sent")
    end