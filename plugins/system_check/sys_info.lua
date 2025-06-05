function get_os()
    if package.config:sub(1,1) == "\\" then  
        return "Windows"
    else
        local os_name = io.popen("uname -s"):read("*l")
        return os_name or "Linux"
    end
end

function system_info()
    local os_type = get_os()
    local architecture = os_type == "Windows" and os.getenv("PROCESSOR_ARCHITECTURE") or io.popen("uname -m"):read("*l")
    local processor = os_type == "Windows" and io.popen("wmic cpu get Name 2>nul"):read("*l") or io.popen("cat /proc/cpuinfo | grep 'model name' | head -1"):read("*l")

    print("[+] System Information:")
    print("    OS:", os_type)
    print("    Architecture:", architecture)
    print("    Processor:", processor)

    if os_type == "Windows" then
        print("[-] Warning: Some modules are Linux-only!")
    else
        print("[+] Full module compatibility.")
    end
end

function check_interpreters()
    local ruby = io.popen("ruby -v 2>nul"):read("*l") or "Not Installed"
    local python = io.popen("python --version 2>nul"):read("*l") or "Not Installed"
    local lua = io.popen("lua -v 2>nul"):read("*l") or "Not Installed"

    print("[+] Installed Interpreters:")
    print("    Ruby:", ruby)
    print("    Python:", python)
    print("    Lua:", lua)
end

function check_network()
    local net_info = os.execute("ipconfig") or os.execute("ifconfig")
    print("[+] Network Interfaces Detected:", net_info)
end

system_info()
check_interpreters()
check_network()