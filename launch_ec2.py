import boto3
ec2 = boto3.client('ec2',region_name='us-east-1')
 
response = ec2.describe_instances()

for reservation in response['Reservations']:
    for instance in reservation['instances']:
        print("Found Ec2 instance id:", instance["instanceid"])