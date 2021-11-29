#!/usr/bin/env python3

import time
import sys
import boto3.ec2
import requests


## Main. ##
if __name__ == '__main__':

        aws_metadata_endpoint_base_url = "http://169.254.169.254/latest"

        session = boto3.Session()
        credentials = session.get_credentials()

        credentials = credentials.get_frozen_credentials()
        access_key = credentials.access_key
        secret_key = credentials.secret_key

        try:
            r = requests.put(aws_metadata_endpoint_base_url + '/api/token', headers={'X-aws-ec2-metadata-token-ttl-seconds': '60'})
            token = r.text
            r.raise_for_status()
        except requests.exceptions.HTTPError as err:
            raise SystemExit(err)

        try:
            r = requests.get(aws_metadata_endpoint_base_url + '/meta-data/placement/region', headers={'X-aws-ec2-metadata-token': token})
            region = r.text
            r.raise_for_status()
        except requests.exceptions.HTTPError as err:
            raise SystemExit(err)

        try:
            r = requests.get(aws_metadata_endpoint_base_url + '/meta-data/instance-id', headers={'X-aws-ec2-metadata-token': token})
            instanceId = r.text  
            r.raise_for_status()
        except requests.exceptions.HTTPError as err:
            raise SystemExit(err)

        elb = boto3.client("elbv2", region_name=region)
        ec2 = boto3.client("ec2", region_name=region)

        reservations = ec2.describe_instances(InstanceIds=[instanceId])['Reservations'][0]
        instance = reservations['Instances'][0]

        for tag in instance['Tags']:
                print(tag['Key'] + ":" + tag['Value'])