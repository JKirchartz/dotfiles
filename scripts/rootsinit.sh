#! /bin/bash
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

set -eou pipefail

DOMAIN="$1"
THEME="${DOMAIN%.*}"
DIR="$PWD/$DOMAIN"

echo "Creating project directory:"
mkdir -p "$DOMAIN"

echo "Clone Trellis:"
git clone --depth=1 git@github.com:roots/trellis.git "$DIR/trellis"
rm -rf "$DIR/trellis/.git"

echo "Cloning Bedrock:"
git clone --depth=1 git@github.com:roots/bedrock.git "$DIR/site"
rm -rf "$DIR/site/.git"
rm -rf "$DIR/site/.github"

echo "Clone Sage:"
git clone https://github.com/roots/sage.git "$DIR/site/web/app/themes/$THEME"
rm -rf "$DIR/site/web/app/themes/$THEME/.git"
rm -rf "$DIR/site/web/app/themes/$THEME/.github"

echo "Installing the Ansible Galaxy roles:"
cd "$DIR/trellis"
ansible-galaxy install -r requirements.yml

echo "Installing JS packages:"
cd "$DIR/site/web/app/themes/$THEME"
npm install
bower install

cd "$DIR"

echo "Creating shortcut to theme..."
ln -s "$DIR/site/web/app/themes/$THEME" theme

echo "Editing Configs..."
files[1]="$DIR/site/web/app/themes/$THEME/assets/manifest.json"
files[2]="$DIR/trellis/group_vars/development/mail.yml"
files[3]="$DIR/trellis/group_vars/development/wordpress_sites.yml"

# `git grep "example.com" | cut -d':' -f'1'`
for file in "${files[@]}"
do
  sed -i '' -e "s/example.dev/$DOMAIN/g" "$file"
done

# remove comments & rename theme in deploy-hooks
sed -i'' -e "/^# ---/,1000 s/#\s?//g" "$DIR/trellis/deploy-hooks/build-before.yml"
sed -i'' -e "s/sage/$THEME/g" "$DIR/trellis/deploy-hooks/build-before.yml"


tee "$DIR/site/web/app/themes/$THEME/style.css" << EOF
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

