function set_green()
    local green = "\27[32m"
    io.write(green)  
    print("[+] CLI color set to GREEN")
end

set_green()