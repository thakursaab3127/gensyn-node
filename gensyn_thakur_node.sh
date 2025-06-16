#!/bin/bash
sudo apt update && sudo apt install -y figlet python3 python3-venv python3-pip curl wget screen git lsof nano unzip iproute2
clear
figlet 'THAKUR SAAB'
echo "🌟 Made by Thakur Saab, Gujarat 🇮🇳"
echo "🔄 Auto‑Restart | 🔐 No Prompts/Input"
cd $HOME
if [ ! -d "$HOME/gensyn-testnet" ]; then
  git clone https://github.com/zunxbt/gensyn-testnet.git
  chmod +x gensyn-testnet/gensyn.sh
fi
mkdir -p $HOME/hivemind_exp/configs/mac
cat <<EOL > $HOME/hivemind_exp/configs/mac/grpo-qwen-2.5-0.5b-deepseek-r1.yaml
model_name: "qwen-2.5-0.5b-deepseek-r1"
model_path: "./models/7"
EOL
mkdir -p $HOME/rl-swarm
cd $HOME/rl-swarm
echo "RL_SWARM_UNSLOTH=False ./run_rl_swarm.sh" > run_rl_swarm.sh
chmod +x run_rl_swarm.sh
cd $HOME
[ -f backup.sh ] && rm backup.sh
curl -sSL -O https://raw.githubusercontent.com/AbhiEBA/gensyn1/main/backup.sh && chmod +x backup.sh
cat <<EOF2 > $HOME/start_gensyn.sh
#!/bin/bash
clear
figlet 'THAKUR SAAB'
echo "🚀 Starting Gensyn Node..."
cd \$HOME/gensyn-testnet && ./gensyn.sh --yes --auto --model 7 --agree-all
cd \$HOME && ./backup.sh
cd \$HOME/rl-swarm && RL_SWARM_UNSLOTH=False ./run_rl_swarm.sh
EOF2
chmod +x $HOME/start_gensyn.sh
cat <<EOL3 | sudo tee /etc/systemd/system/gensyn-thakur.service > /dev/null
[Unit]
Description=Gensyn AI Node by Thakur Saab
After=network.target

[Service]
Type=simple
User=$USER
ExecStart=/bin/bash $HOME/start_gensyn.sh
Restart=always
RestartSec=10
Environment=PATH=/usr/bin:/bin:/usr/local/bin

[Install]
WantedBy=multi-user.target
EOL3
sudo systemctl daemon-reload
sudo systemctl enable gensyn-thakur
sudo systemctl restart gensyn-thakur
clear
figlet 'THAKUR SAAB'
echo ""
echo "🎉 Setup Complete! No login/prompts needed, auto-restarts enabled."
echo "📺 Logs via: journalctl -fu gensyn-thakur"
echo "✅ Munna ready to roll!"
