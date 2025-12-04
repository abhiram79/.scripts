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

echo 'Installing sudo and utils...'
apt install -y sudo passwd

echo 'Creating user: debian'
useradd -m -s /bin/bash debian

echo 'Setting password to: debian'
echo 'debian:debian' | chpasswd

echo 'Adding user to sudoers...'
usermod -aG sudo debian

# Ensure password-based sudo works
sed -i 's/# %sudo/%sudo/' /etc/sudoers

echo 'Done configuring Debian.'
"

echo ""
echo "=============================="
echo " Debian Installed Successfully!"
echo " User: debian"
echo " Password: debian"
echo "=============================="
echo ""

echo "Creating shortcut launcher: debian"
cat > $PREFIX/bin/debian << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
proot-distro login debian --user debian
EOF

chmod +x $PREFIX/bin/debian

echo "Type debian to enter the distro"
echo "github.com/abhiram79"
