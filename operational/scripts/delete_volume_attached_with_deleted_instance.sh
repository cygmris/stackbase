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



while read -u 3 line
do
        volume_id=`echo $line | cut -d " " -f 1`
        instance_id=`echo $line | cut -d " " -f 4`
        if [[	$instance_id =~ $pat	]];then
					read -d '' QUERY_VM_STATE<<-EOF
					select vm_state from instances where uuid = '$instance_id';
					EOF
					QUERY="select vm_state from instances where uuid = instance_id;"
					VM_STATE=`echo $QUERY_VM_STATE | mysql --host=$MYSQL_HOST --user=$MYSQAL_USER --password=$MYSQL_PASSWORD --database=nova -ss`
					if [[	$VM_STATE == "deleted"	]];
					then
						read -p "Are you sure to delete volume: $volume_id with instance_id: $instance_id? [y/N] " response
						case "$response" in
						[yY][eE][sS]|[yY]) 
							delete_volume $volume_id
						;;
						*)
							echo "Not do anything with volume: $volume_id"
						;;
						esac
					else
						:
					fi
					else
						:
				fi    

#echo "volumeid: $volume_id, instanceid: $instance_id"
					done 3< <(openstack volume list -c ID --format value -c "Attached to" --format value)
