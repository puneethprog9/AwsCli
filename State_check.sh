#!/bin/bash
echo -n "enter instance id:"
read id
 aws ec2 describe-instances  --filters "Name=instance-id,Values=$id"  --query 'Reservations[*].Instances[*].State.Name' --output text



