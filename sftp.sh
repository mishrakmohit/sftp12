mkdir -p /uploads/inanzzz
sudo mkdir -p /uploads/inanzzz/upload
touch /uploads/inanzzz/upload/file.txt
sudo chmod 500 /uploads/inanzzz/upload

useradd -d /uploads/inanzzz -G sftp inanzzz -s /usr/sbin/nologin
echo "inanzzz:inanzzz" | sudo chpasswd
sudo chown inanzzz:sftp -R /uploads/inanzzz/upload
