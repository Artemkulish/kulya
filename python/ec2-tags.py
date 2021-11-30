#!/usr/bin/env python3

import time
import sys

import boto3.ec2
import requests

def get_ec2_metadata(path, header_value, method="get", header_name="X-aws-ec2-metadata-token", aws_metadata_endpoint_base_url="http://169.254.169.254/latest"):
    try:
        response = requests.request(method, aws_metadata_endpoint_base_url + path, headers={header_name: header_value})
        response.raise_for_status()
    except requests.exceptions.RequestException as err:
        raise SystemExit(err)
    else:
        result = response.text

    return result

## Main. ##
if __name__ == '__main__':

        session = boto3.Session()
        credentials = session.get_credentials()

        credentials = credentials.get_frozen_credentials()
        access_key = credentials.access_key
        secret_key = credentials.secret_key

        token = get_ec2_metadata("/api/token", "60", "put", "X-aws-ec2-metadata-token-ttl-seconds")
        region = get_ec2_metadata("/meta-data/placement/region", token)
        instanceId = get_ec2_metadata("/meta-data/instance-id", token)

        elb = boto3.client("elbv2", region_name=region)
        ec2 = boto3.client("ec2", region_name=region)

        reservations = ec2.describe_instances(InstanceIds=[instanceId])['Reservations'][0]
        instance = reservations['Instances'][0]

        for tag in instance['Tags']:
                print(tag['Key'] + ":" + tag['Value'])