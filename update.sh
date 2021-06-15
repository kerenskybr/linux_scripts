# Update, upgrade and clean in one command
# usage: ./update.sh
sudo apt update && \
sudo apt upgrade && \
sudo apt autoremove && \
sudo apt clean
