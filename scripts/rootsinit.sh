#! /bin/sh
#
# rootsinit.sh
#
# Copyleft (ↄ) 2016 joel <me@jkirchartz.com>
#
# Distributed under terms of the NPL (Necessary Public License) license.
#

if [ $# -eq 0 ]; then
  echo "please provide a domain name for this project"
  echo "$> rootsinit.sh example.com"
  exit;
fi


echo "Creating project directory:"
mkdir $1
cd $1
(
echo "Clone Trellis:"
git clone --depth=1 git@github.com:roots/trellis.git
rm -rf trellis/.git
echo "Cloning Bedrock:"
git clone --depth=1 git@github.com:roots/bedrock.git site
rm -rf site/.git
echo "Clone Sage:"
git clone https://github.com/roots/sage.git site/web/app/themes/sage
rm -rf site/web/app/themes/sage/.git
rm -rf site/web/app/themes/sage/.github
)
echo "Installng the Ansible Galaxy roles:"
(
cd $1/trellis
ansible-galaxy install -r requirements.yml
)

echo "Creating shortcut to theme"
ln -s site/web/app/themes/sage theme

git init
git add .
git commit -am "Initial commit for $1"

for file in `git grep "example.com" | cut -d':' -f'1'`
do
  sed -e "s#example.com|example.dev#$1#g" $file > $file.tmp
  mv $file.tmp $file;
done

git add .
git commit -am "Configure domain info for $1"

