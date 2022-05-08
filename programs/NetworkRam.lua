local computer = require("computer")
local com = require("component")
local net = com.modem
assert(net, "Youre trying to do networking and you dont even have a network card")
if not net.isOpen(69) then
  net.open(69)
end
os.execute("clear")
print("Sending thru da intranet")
os.sleep(1)
local total = computer.totalMemory()
 if modem.broadcast(69, "Total memory:") then
    print("Total memory:")
    else
    print("The data was not sent")
    end
if modem.broadcast(69, total.." Byte") then
    print(total.." Byte")
    else
    print("The data was not sent")
    end
if modem.broadcast(69, total/1024 .." KiloByte") then
    print(total/1024 .." KiloByte")
    else
    print("The data was not sent")
    end
if modem.broadcast(69, total/1048576 .." MegaByte\n") then
    print(total/1048576 .." MegaByte\n")
    else
    print("The data was not sent")
    end

os.sleep(1)
local free = computer.freeMemory()
print("Free memory:")
print(free.." Byte")
print(free/1024 .." KiloByte")
print(free/1048576 .." MegaByte\n")

os.sleep(1)
print("Memory used:")
print(string.format("%i%% memory is used", math.floor((1-(free/total))*100 + 0.5)))
print(total-free .." Byte")
print((total-free)/1024 .." KiloByte")
print((total-free)/1048576 .." MegaByte")
