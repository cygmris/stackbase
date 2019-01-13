#!/bin/bash
create_users(){
fullname=$1
openstack project create --domain default \
--description "tenent $fullname" $fullname
openstack user create --domain default \
--password $fullname $fullname
openstack role add --project $fullname --user $fullname user
}
read -p "Enter fullname: " names
if [[ $names == "" ]];
then
exit 1
fi
for name in $names;do
create_users $name
done
# user=$(zenity --entry --text 'Please enter the username:') || exit 1

