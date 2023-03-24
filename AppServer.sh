#!/bin/bash
wget https://packages.microsoft.com/config/ubuntu/22.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb\nrm packages-microsoft-prod.deb
apt-get update && apt-get install -y dotnet-sdk-7.0
apt-get update && apt-get install -y aspnetcore-runtime-7.0
    