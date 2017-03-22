#!/bin/bash

aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query 'Reservations[*].Instances[*].[PublicIpAddress,BlockDeviceMappings[0].Ebs.AttachTime,Tags[0].Value]' --output text >Instances2.txt

IFS=$'\n'

for Instance in $(cat Instances2.txt); do
    
    ip=$(echo $Instance | awk '{print $1;}')
 atime=$(echo $Instance | awk '{print $2;}'| cut -c-10 )
  node=$(echo $Instance | awk '{print $3;}')
 rtime=$(date +%F)

  if [ $atime==$rtime ]; then
 echo knife bootstrap $ip -X ec2-user -i boot.pem -N $node
fi


done
