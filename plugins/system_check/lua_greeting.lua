function startup_message()
    print("[+] Welcome to BeaverSploit CLI!")
    print("[+] Running on Lua version:", _VERSION)
end

function check_env()
    local ruby = io.popen("ruby -v"):read("*a")
    local python = io.popen("python --version"):read("*a")

    print("[+] Ruby Version:", ruby:match("ruby ([%d%.]+)"))
    print("[+] Python Version:", python:match("Python ([%d%.]+)"))
end

startup_message()
check_env()