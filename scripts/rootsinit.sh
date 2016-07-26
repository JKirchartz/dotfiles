#! /bin/sh
#
# rootsinit.sh
#
# 2016 Joel Kirchartz <joel@firemancreative.com>
#

if [ $# -eq 0 ]; then
  echo "please provide a domain name for this project"
  echo "$> rootsinit.sh example.dev"
  exit;
fi

DOMAIN="$1"
THEME="${DOMAIN%.*}"

echo "Creating project directory:"
mkdir $DOMAIN

echo "Clone Trellis:"
git clone --depth=1 git@github.com:roots/trellis.git "$DOMAIN/trellis"
rm -rf "$DOMAIN/trellis/.git"

echo "Cloning Bedrock:"
git clone --depth=1 git@github.com:roots/bedrock.git site
rm -rf site/.git

echo "Clone Sage:"
git clone https://github.com/roots/sage.git "$DOMAIN/site/web/app/themes/$THEME"
rm -rf "$DOMAIN/site/web/app/themes/$THEME/.git"
rm -rf "$DOMAIN/site/web/app/themes/$THEME/.github"

echo "Installing the Ansible Galaxy roles:"
cd "$PWD/$DOMAIN/trellis"
ansible-galaxy install -r requirements.yml

echo "Installing JS packages"
cd "$PWD/$DOMAIN/site/web/app/themes/$THEME"
npm install
bower install

cd "$PWD/$DOMAIN"

echo "Creating shortcut to theme"
ln -s "$PWD/$DOMAIN/site/web/app/themes/sage" theme

files[1]="$DOMAIN/site/web/app/themes/$THEME/assets/manifest.json"
files[2]="$DOMAIN/trellis/group_vars/development/mail.yml"
files[3]="$DOMAIN/trellis/group_vars/development/wordpress_sites.yml"

# `git grep "example.com" | cut -d':' -f'1'`
for file in "${files[@]}"
do
  echo $DOMAIN
  echo $file
  if [ -f $file ]; then
    echo 'exists'
  fi
  sed -i '' -e "s/example.dev/$DOMAIN/g" $file
done

git init
git add .
git commit -am "Initial commit for $DOMAIN"

