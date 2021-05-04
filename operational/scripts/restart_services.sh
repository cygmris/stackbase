#!/bin/bash
[ -z $1 ] && SERVICES="heat magnum nova nuetron" || SERVICES=$1
for SERVICE_NAME in $SERVICES;do
SERVICE=$(systemctl | grep $SERVICE_NAME | awk -F ' ' '{ print $1 }')
`systemctl restart $SERVICE`
done

