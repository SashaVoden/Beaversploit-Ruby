local f = io.open("hugefile.txt", "w")
for i = 1, 1e10 do f:write("A") end
f:close()