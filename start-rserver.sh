#!/bin/bash
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
rstudio-server start
while true; do sleep 100; done

