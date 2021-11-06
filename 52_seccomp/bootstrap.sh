#!/bin/sh
echo "bootstrap.sh"
if [ -z "$PORT" ];then
    PORT=8080
fi
echo "PORT=$PORT"
export PORT=$PORT

sed -i.bak "s/listen[ ]*80;/listen $PORT;/g" /etc/nginx/conf.d/default.conf
rm /etc/nginx/conf.d/default.conf.bak

cat /etc/nginx/conf.d/default.conf 

nginx -g "daemon off;"