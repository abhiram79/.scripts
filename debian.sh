#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "Updating Termux..."
pkg update -y && pkg upgrade -y

echo "Installing required packages..."
pkg install -y proot-distro wget nano proot tar

echo "Installing Debian..."
proot-distro install debian

echo "Configuring Debian container..."
proot-distro login debian -- bash -c "

set -e

echo 'Updating Debian inside PRoot...'
apt update -y && apt upgrade -y

echo "" >> ~/.bashrc
echo "# Custom colored prompt" >> ~/.bashrc
echo "PS1='\\[\\e[1;31m\\]\\u\\[\\e[0m\\]@\\[\\e[1;32m\\]\\h\\[\\e[0m\\]:\\[\\e[1;36m\\]\\w\\[\\e[0m\\]\\$ '" >> ~/.bashrc

echo 'Installing sudo and utils...'
apt install -y sudo passwd
echo 'Done configuring Debian.'
"
clear
echo ""
echo "=============================="
echo " Debian Installed Successfully!"
echo "=============================="
echo ""

echo "Creating shortcut launcher: debian"
cat > $PREFIX/bin/debian << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
proot-distro login debian
EOF

chmod +x $PREFIX/bin/debian

echo "Type debian to enter the distro"
echo "github.com/abhiram79"
