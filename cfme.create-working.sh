#!/bin/bash
#wget \
#https://access.cdn.redhat.com//content/origin/files/sha256/3e/3e36464d712c338e09db43e9983d8864641c8387530d7527bf6b1a47413689dc/cfme-rhos-5.6.1.2-1.x86_64.qcow2?_auth_=1472546742_af36f10a3f47a96ffd6bc5199bf3f08b \
#-o cfme-rhos-5.6.1..x86_64.qcow2
#mv cfme-rhos-5.6.1.2-1* cfme-rhos-5.6.1.x86_64.qcow2
#qemu-img convert -O raw cfme-rhos-5.6.1.x86_64.qcow2 myimage-temp.raw
#VMDKstream.py myimage-temp.raw myimage-for-aws.vmdk
#mv myimage-for-aws.vmdk cfme-rhos-5.6.1.x86_64.vmdk
#mv cfme-rhos-5.6.1.x86_64.vmdk cloudforms/
#rm -fr myimage-temp.raw
#cd cloudforms/
export VMDK_IMAGE=/root/cloudforms/cfme-rhos-5.6.1.x86_64.vmdk
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.91-1.b14.el7_2.x86_64/jre
export AWS_S3_BUCKET=cloudforms-ami
export AWS_SECRET_KEY=
export AWS_ACCESS_KEY=
export EC2_HOME=/usr/local/ec/ec2-api-tools-1.7.5.1
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.91-1.b14.el7_2.x86_64/jre
cd /usr/local/ec/ec2-api-tools-1.7.5.1/bin/
systemctl status ntpd
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
