# Garantindo as chaves

KEY_PATH='/vagrant/files'
mkdir -p /root/.ssh
cp $KEY_PATH/key /root/.ssh/id_rsa
cp $KEY_PATH/key.pub /root/.ssh/id_rsa.pub
cp $KEY_PATH/key.pub /root/.ssh/authorized_keys
chmod 400 /root/.ssh/id_rsa*
cat /root/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys

# Garantindo os hosts

HOSTS=$(head -n7 /etc/hosts)
echo -e "$HOSTS" > /etc/hosts
echo '192.168.56.10 automation.maximus.tech' >> /etc/hosts
echo '192.168.56.20 compliance.maximus.tech' >> /etc/hosts
echo '192.168.56.30 container.maximus.tech chat.maximus.tech' >> /etc/hosts
echo '192.168.56.40 scm.maximus.tech' >> /etc/hosts
echo '192.168.56.50 log.maximus.tech' >> /etc/hosts

# Criando arquivo de SWAP
#fallocate -l 1G /swapfile
#chmod 600 /swapfile
#mkswap /swapfile
#echo -e "/swapfile swap swap defaults 0 0" >> /etc/fstab
#swapon -a
