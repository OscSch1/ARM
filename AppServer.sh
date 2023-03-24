#!/bin/bash
wget https://packages.microsoft.com/config/ubuntu/22.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
apt-get update && apt-get install -y dotnet-sdk-7.0
apt-get update && apt-get install -y aspnetcore-runtime-7.0

cat << EOF > /etc/systemd/system/ReverseProxy.service
[Unit]
Description=CiCdDemo

[Service]
WorkingDirectory=/home/azureuser/actions-runner/_work/CICD/CICD
ExecStart= dotnet /home/azureuser/actions-runner/_work/CICD/CICD/CICD.dll

[Install]
WantedBy=multi-user.target
EOF

mkdir actions-runner && cd actions-runner
curl -o actions-runner-linux-x64-2.303.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.303.0/actions-runner-linux-x64-2.303.0.tar.gz
tar xzf ./actions-runner-linux-x64-2.303.0.tar.gz
./config.sh --url https://github.com/OscSch1/CICD2 --token $token --unattended
systemctl daemon-reload
systemctl enable ReverseProxy.service
systemctl start ReverseProxy.service
./run.sh
