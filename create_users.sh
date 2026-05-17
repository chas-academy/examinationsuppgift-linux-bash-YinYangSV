#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo "Kör som root!"
    exit 1
fi

for user in "$@" ; do
    echo "Söker användare för $user"
    id "$user" &>/dev/null
if [ $? -eq 0 ]; then
    echo "Användaren $user finns redan i systemet"
    continue
fi

useradd -m "$user"

mkdir /home/$user/Downloads
mkdir /home/$user/Work
mkdir /home/$user/Documents

chmod 700 /home/$user
chmod 700 /home/$user/Downloads
chmod 700 /home/$user/Work
chmod 700 /home/$user/Documents

echo "Välkommen $user" > /home/$user/welcome.txt

cut -d: -f1 /etc/passwd | grep -v "^$user$" >> /home/$user/welcome.txt

chown -R $user:$user /home/$user

done
