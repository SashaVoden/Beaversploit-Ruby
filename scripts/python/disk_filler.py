with open("hugefile.txt", "wb") as f:
    f.write(b"A" * 10**10)