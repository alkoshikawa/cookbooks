#!/bin/bash

genpasswd() {
        local l=$1
        [ "$l" == "" ] && l=16
        tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}


TMP=/usr/local/chef-repo

# git clone
if [ ! -d $TMP ]; then
	git clone https://github.com/alkoshikawa/cookbooks.git /tmp/chef-repo >> /tmp/instance-initilize.log 2>&1
else
	cd $TMP
	git fetch
        git merge origin/master
fi

# ec2 parameter set
INSTANCE_TYPE=`curl http://169.254.169.254/latest/meta-data/instance-type`
INSTACE_ID=`curl http://169.254.169.254/latest/meta-data/instance-id`
PUBLIC_DOMAIN=`curl http://169.254.169.254/latest/meta-data/public-hostname`

RAND8=`genpasswd 8`
RAND16=`genpasswd 16`
DATABASE_NAME=$INSTACE_ID
DATABASE_USER="ec_${RAND8}"
DATABASE_PASS=${RAND16}

echo "DATABASE_NAME $DATABASE_NAME" >> /tmp/instance-initilize.log 2>&1
echo "DATABASE_USER $DATABASE_USER" >> /tmp/instance-initilize.log 2>&1
echo "DATABASE_PASS $DATABASE_PASS" >> /tmp/instance-initilize.log 2>&1

METADATA=/usr/local/chef-repo/cookbooks/setup-eccube/attributes/server.rb
sed -i "s/___database_pass___/${DATABASE_PASS}/g" $METADATA
sed -i "s/___database_user___/${DATABASE_USER}/g" $METADATA
sed -i "s/___database_name___/${DATABASE_NAME}/g" $METADATA

chef-solo -o setup-eccube


