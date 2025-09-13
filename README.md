# terraform-instance-class7

There are total of 37 global regions hosting an AWS cloud provider as of today, each region is geographically isolated in locations around the world and located in a safe economically viable location and connected via high speed low latency fiber-optic links to establish communication and to insure failover.
Failover allows traffic in one region or AZ to be redirected to the new location in the event of natural disaster or a region gets compromised. Regional cloud services examples are 
Amazon Route 53, Global Accelerator, Cloud Front (CDN), lambda, and Object storage (s3). There are approximately 3 avialability zones (AZ) that exist within a region consisting of databases. These databases can be on-premise infratructure with their network of teams ranging from HVAC, human resources, and financial department. Each database within the AZ can each jave their own private virtual private cloud (VPC). A VPC is broken down in subnets that isolate workloads to from the public internet. Within each VPC we have virtual servers also known as Ec2 instances that act as virtual machines with their own CPU, RAM, and processor.

steps: using terraform 

1. configure a providers.tf file to run
      terraform init

  terraform init command to access the latest terraform update and provider plugins

2. Use a resource block for Ec2 instance configuration along with a security groups
       terraform plan

  run a terraform plan to see what resources you are adding

3. To deploy your cloud resources
       terraform apply

  run terraform apply to deploy your resources for monitoring and provisioning 

4. Destroy your cloud resources to prevent accumlating an unnecessary bill
      terraform destroy

