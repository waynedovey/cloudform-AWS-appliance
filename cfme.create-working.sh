#!/bin/bash
mkdir -p /usr/local/ec/
mkdir cloudforms/
unzip ec2-api-tools.zip
mv ec2-api-tools-1.7.5.1 /usr/local/ec/
mv cfme-ec2-5.6.2.1-1.x86_64.vhd cfme-rhos-5.6.1.x86_64.qcow2
yum install qemu-img -y
yum install java-1.8.0-openjdk-1.8.0.102 -y
qemu-img convert -O raw cfme-rhos-5.6.1.x86_64.qcow2 myimage-temp.raw
./VMDKstream.py myimage-temp.raw myimage-for-aws.vmdk
mv myimage-for-aws.vmdk cfme-rhos-5.6.1.x86_64.vmdk
mv cfme-rhos-5.6.1.x86_64.vmdk cloudforms/
rm -fr myimage-temp.raw
cd cloudforms/
export VMDK_IMAGE=/root/cloudforms/cloudform-AWS-appliance/cloudforms/cfme-rhos-5.6.1.x86_64.vmdk
export JAVA_HOME=/usr/lib/jvm/jre-1.8.0/
export AWS_S3_BUCKET=cloudforms-ami-macbank
export AWS_ACCESS_KEY=
export AWS_SECRET_KEY=
export EC2_HOME=/usr/local/ec
export JAVA_HOME=/usr/lib/jvm/jre-1.8.0/
export export PATH=$PATH:$EC2_HOME
systemct lstatus ntpd
systemctl start ntpd
systemctl status ntpd
systemctl restart ntpd
date
./ec2-import-instance ${VMDK_IMAGE} -f vmdk -t m3.large -a x86_64 -b ${AWS_S3_BUCKET} -p Linux -o ${AWS_ACCESS_KEY} -w ${AWS_SECRET_KEY} --region ap-southeast-2
./ec2-delete-disk-image --help
./ec2-describe-conversion-tasks -O ${AWS_ACCESS_KEY} -W ${AWS_SECRET_KEY} --region ap-southeast-2
./ec2-delete-disk-image -O ${AWS_ACCESS_KEY} -W ${AWS_SECRET_KEY} --region ap-southeast-2 -t import-i-fgag32ao
./ec2-describe-conversion-tasks -O ${AWS_ACCESS_KEY} -W ${AWS_SECRET_KEY} --region ap-southeast-2
./ec2-describe-conversion-tasks -O ${AWS_ACCESS_KEY} -W ${AWS_SECRET_KEY} --region ap-southeast-2
