# 🧪 AWS Systems Manager Session Management 

This service allows you to safely monitor your servers from a security compliance focus. Session management reduces key leakage and lowers your attack surface by eliminating the need to open port 22 for SSH connection or using a Bastion host, and reducing operational overhead. SSM also eliminates single point of failure since it scales automatically. No network inbound access is required is the biggest advantage, in order to use Systems manager affectively there are three things that must be configured first. No inbound ports or public IP address are needed 

# ☁️ SSM

1. IAM role allowing an EC2 instance to be monitored by AWS Systems Manager

2. EC2 and SSM/EC2 message endpoints need to be configured in your VPC for direct communication.

3. TCP port 443 needs to be opened for outbound HTTPS traffic to AWS API's

4. SSM and VPC flow logs should be sent to S3 with block public access versioning and SSE enabled.

✅ The goal is for your private EC2 instances to have full egress at the Security Group layer, while maintaining egress control using a Network Address Translation (NAT), VPC endpoints, and routing. This prevents the DNS and AWS dependencies from breaking. Ingress traffic is locked down using SSM.

🔐 The goal for securing public EC2 instances is to enforce the PoLP and zero-trust with IAM, and to use HTTPS tcp 443 over HTTP tcp 80 for SSL/TLS encyption for data packets in transit and to avoid opening SSH port 22 to reduce attack surface. Only open the necessary ports. Place a ALB in front of your public EC2 with a WAF security backend for your ALB for compliance with OWASP top 10. Do not store access secrets keys on disk, use SSM secretes manager. 

correct            
SSM ✅
ALB✅
VPC Endpoint✅
NAT✅
SG rule for HTTPS tcp port 443✅

incorrect/No longer best practice 
SSH tcp port 22🚫
Bastion Host🚫
relying on IGW🚫
deploying servers in public subnet🚫

Once in AWS systems Manager check your network interfaces by showing IP address
        
        ifconfig

Apply a security Update

        sudo yum update --security -y

![image alt](https://github.com/DMayrant/AWS-Systems-Manager/blob/main/SSM.jpeg?raw=true)        
