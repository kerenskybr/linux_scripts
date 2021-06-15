# Add a new user to machine and set permissions
# Usage: $ ./create_user <username>
useradd $1
mkdir -p /home/$1/.ssh
touch /home/$1/.ssh/authorized_keys
chown -R $1 /home/$1
chmod 600 /home/$1/.ssh/authorized_keys
chmod 700 /home/$1/.ssh
usermod -a -G docker $1
usermod -a -G users $1
