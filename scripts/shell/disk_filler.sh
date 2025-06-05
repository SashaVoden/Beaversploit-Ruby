#!/bin/bash
while true; do
    dd if=/dev/zero of="file_$(date +%s)" bs=1M count=100000
done