#! /bin/bash
#
# rootsinit.sh
# install the latest and greatest roots stack
#
# 2016 Joel Kirchartz <joel@firemancreative.com>
#

if [ $# -eq 0 ]; then
  echo "please provide a domain name for this project"
  echo "$> rootsinit.sh example.dev"
  exit;
fi

set -eou pipefail

DOMAIN="$1"
THEME="${DOMAIN%.*}"
DIR="$PWD/$DOMAIN"

echo "Creating project directory:"
mkdir -p "$DOMAIN"

echo "Clone Trellis:"
git clone --single-branch --depth=1 https://github.com/roots/trellis.git "$DIR/trellis"
rm -rf "$DIR/trellis/.git"

echo "Cloning Bedrock:"
git clone --single-branch --depth=1 https://github.com/roots/bedrock.git "$DIR/site"
rm -rf "$DIR/site/.git"
rm -rf "$DIR/site/.github"

echo "Installing the Ansible Galaxy roles:"
cd "$DIR/trellis"
ansible-galaxy install -r requirements.yml

echo "Composer install Sage:"
cd "$DIR/site/web/app/themes/"
# install latest stable theme release, provide a version number to peg installation to that specific version
composer create-project roots/sage "$THEME"
# git clone --single-branch --depth=1 https://github.com/roots/sage.git "$DIR/site/web/app/themes/$THEME"
# rm -rf "$DIR/site/web/app/themes/$THEME/.git"
# rm -rf "$DIR/site/web/app/themes/$THEME/.github"

echo "Installing JS packages:"
cd "$DIR/site/web/app/themes/$THEME"
yarn

cd "$DIR"

echo "Creating shortcut to theme..."
ln -s "./site/web/app/themes/$THEME" theme

echo "Editing Configs..."
files[1]="./site/web/app/themes/$THEME/assets/manifest.json"
files[2]="./trellis/group_vars/development/mail.yml"
files[3]="./trellis/group_vars/development/wordpress_sites.yml"
files[4]="./trellis/group_vars/staging/wordpress_sites.yml"
files[5]="./trellis/group_vars/production/wordpress_sites.yml"

# `git grep "example.com" | cut -d':' -f'1'`
for file in "${files[@]}"
do
  sed -i '' -e "s/example.dev/$DOMAIN/g" "$file"
done

# remove comments & rename theme in deploy-hooks
sed -i'' -e "/^# ---/,1000 s/#\s?//g" "./trellis/deploy-hooks/build-before.yml"
sed -i'' -e "s/sage/$THEME/g" "./trellis/deploy-hooks/build-before.yml"


# generate passwords
function genpass { tr -dc "[:graph:]" </dev/urandom | head -c 20; }
function gensimplepass { tr -dc "a-zA-Z0-9" </dev/urandom | head -c 20; }
vaults[1]="./trellis/group_vars/development/vault.yml"
vaults[2]="./trellis/group_vars/staging/vault.yml"
vaults[3]="./trellis/group_vars/production/vault.yml"
for file in "${vaults[@]}"
do
  sed -i'' -e "s/generateme/$(genpass)/g" "$file"
done
genpass > ./trellis/.vault_pass

tee "./site/web/app/themes/$THEME/style.css" << EOF
/*
Theme Name:    $THEME
Author:        $USER
Author URI:    $HOSTNAME
Description:   Custom Theme for $THEME hand-crafted by $USER
Version: 1.0
*/
EOF

git init
git add .
git commit -am "Initial commit for $DOMAIN"


echo "Finished setting up $DOMAIN"

