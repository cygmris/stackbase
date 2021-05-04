#!/bin/bash
MYSQL_HOST=$1
MYSQL_USER=$2
MYSQL_PASSWORD=$3
pat="\S{8}-\S{4}-\S{4}-\S{4}-\S{12}"
delete_volume(){
volume_uuid=$1
read -d '' DELETE_VOLUME_SQL<<-EOF
update volumes set attach_status='detached',status='available' where id ='$volume_uuid';
update volume_attachment set attach_status='detached',deleted=1,detach_time=now() WHERE volume_id='$volume_uuid';
EOF
RESULT=`echo $DELETE_VOLUME_SQL | mysql --host=$MYSQL_HOST --user=$MYSQAL_USER --password=$MYSQL_PASSWORD --database=cinder`
echo $(openstack volume delete $volume_uuid)
echo "volume: $volume_uuid deleted"
# update volumes set deleted=1,status='deleted',deleted_at=now(),updated_at=now() where deleted=0 and id='$volume_uuid'; (optional)
}
delete_volume $4
