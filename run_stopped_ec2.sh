#!/bin/bash

for instance in $(cat file1);
do 
  aws ec2 start-instances --instance-ids $instance
done
