#!bin/bash
echo "1. install PHP/mySQL/GD"
yum install php53 php53-cli php53-common php53-gd php53-mbstring php53-mysql php53-pdo
echo "2. Download Wordpress & unzip"
wget http://wordpress.org/latest.tar.gz
tar xfz latest.tar.gz
echo "3. move Wordpress to current dir & clean up"
mv wordpress/* ./
rmdir ./wordpress/
rm -f ./latest.tar.gz
echo "4. copy Wordpress config sample to wp-config.php"
cp wp-config-sample.php wp-config.php
echo "5. download https://api.wordpress.org/secret-key/1.1/salt/ as wp-salt.txt"
wget -O wp-salt.txt https://api.wordpress.org/secret-key/1.1/salt/
echo "6. edit wp-config.php, replace lines 45-52 (unique keys/salts) with content from wp-salt"
sed -i ... -e '45,52d' -e '44r wp-salt.txt' wp-config.php
