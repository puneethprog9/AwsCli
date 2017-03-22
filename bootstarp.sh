#!/bin/bash


rm -f Instances.txt


aws ec2 describe-instances --filter "Name=instance-state-name,Values=running" --query 'Reservations[*].Instances[*].[PublicIpAddress,BlockDeviceMappings[*].Ebs.AttachTime]' --output text  | sed 'N;s/\n/ /' >> Instances.txt


IFS=$'\n'

for Instance in $(cat Instances.txt); do
    

   ip=$(echo $Instance | awk '{print $1;}')
 atime=$(echo $Instance | awk '{print $2;}'| cut -c-10 )
 
 rtime=$(date +%F)

  if [ $atime == $rtime ]; then
 echo knife bootstrap $ip -X ec2-user -i boot.pem -N node
fi


done
