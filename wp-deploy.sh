#/bin/bash

echo "Downloading the latest nightly build of WordPress..."
wget -q http://wordpress.org/nightly-builds/wordpress-latest.zip
mkdir wp-deploy-nightly
unzip -qq -o wordpress-latest.zip -d wp-deploy-nightly
rm wordpress-latest.zip

echo "Downloading the latest stable version of WordPress..."
wget -q http://wordpress.org/latest.tar.gz
mkdir wp-deploy-stable
tar -xzf latest.tar.gz -C wp-deploy-stable
rm latest.tar.gz

IFS=' '
while read -r target version;
do
    if [ $version == "n" ]; then
        printf "Deploying the nightly build to %s...\n" $target
        cp -r ./wp-deploy-nightly/wordpress/* $target
    elif [ $version == "s" ]; then
        printf "Deploying the stable version to %s...\n" $target
        cp -r ./wp-deploy-stable/wordpress/* $target
    fi
done < wp-deploy.conf

rm -r wp-deploy-{nightly,stable}