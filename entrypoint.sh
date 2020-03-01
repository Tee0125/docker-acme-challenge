#!/bin/bash

if [ ${#CF_APIKEY} -lt 1 ] || [ ${#CF_EMAIL} -lt 1 ]; then 
    echo "Missing environment variables"
    echo ""
    echo "CF_APIKEY"
    echo "CF_EMAIL"

    exit 1
fi

export CF_KEY=${CF_APIKEY}

if [ ! -d /var/lib/dehydrated/accounts ]; then
    /opt/dehydrated/dehydrated --register --accept-terms
fi

/opt/dehydrated/dehydrated --cron                   \
           --hook /opt/hook/hook.py \
           --challenge dns-01

last=`date +%y%m%d`

while [ 1 ] ; do
    cur=`date +%y%m%d`

    if [ $last != $cur ]; then
        d=`date +%d`
        if [ $d == "1" ] || [ $d == "15" ] ; then
            /opt/dehydrated/dehydrated --cron   \
                       --hook /opt/hook/hook.py \
                       --challenge dns-01
    
            last=`date +%y%m%d`
        fi
    fi

    sleep 3600
done
