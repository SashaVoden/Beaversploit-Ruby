import subprocess

dependencies = {
    "Ruby": "ruby -v",
    "Bundler": "bundle -v",
}

for name, command in dependencies.items():
    try:
        output = subprocess.check_output(command, shell=True, stderr=subprocess.DEVNULL).decode().strip()
        print(f"{name}: {output}")
    except subprocess.CalledProcessError:
        print(f"{name}: Not installed")