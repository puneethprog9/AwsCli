#!/bin/bash

for instance in $(aws ec2 describe-instances  --filters "Name=instance-state-name,Values=stopped" \
 --query 'Reservations[*].Instances[*].InstanceId' --output text);
do 
   aws ec2 start-instances --instance-ids $instance
done
