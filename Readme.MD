# 1. Creating Static website

## Step 1: Create a bucket

![Alt text](3.png?raw=true "Optional Title")

## Step 2: Enable static website hosting

![Alt text](4.png?raw=true "Optional Title")

## Step 3: Edit Block Public Access settings

![Alt text](1.png?raw=true "Optional Title")

## Step 4: Add a bucket policy that makes your bucket content publicly available

![Alt text](2.png?raw=true "Optional Title")

## Step 5: Configure an index document

![Alt text](5.png?raw=true "Optional Title")

## Step 6: Configure an error document

## Step 7: Test your website endpoint

![Alt text](6.png?raw=true "Optional Title")

## =============================================================================

# 2. Mount an s3 bucket to EC2 server

## Create an EC2 Linux instance

sudo yum update -y
sudo yum install awscli -y
sudo yum install s3fs -y

## Login to your Ec2 Instance

mkdir /home/ec2-user/bucket; cd $HOME/bucket ;touch test1.txt test2.txt test3.txt

## Go to S3 service and create a new bucket

## Once the bucket is created, go to the ssh session and configure our AWS credentails for authentication using the IAM account that we have created.
 
 aws configure

## Now run the below command to sync local directory with the S3 bucket

aws s3 sync /home/ec2-user/bucket s3://s3fs-test-nov

## create the credential file for s3fs

cat > /etc/passwd-s3fs
$AWS_ACCESS_KEY_ID:$AWS_SECRET_KEY_ID

## Now you can run the command to mount S3 bucket as a filesystem
sudo s3fs s3fs-test-nov /home/ec2-user/bucket  -o passwd_file=/etc/passwd-s3fs,nonempty,rw,allow_other,mp_umask=002,uid=1000,gid=1000 -o url=http://s3.ap-southeast-2.amazonaws.com,endpoint=ap-southeast-2,use_path_request_style

## Once it is mounted successfully, you can verify by running the command

mount|grep s3fs

## Add the entry in fstab using the below command so that the changes become persistent after the server reboot as well

s3fs-test-nov /home/ec2-user/bucket fuse.s3fs _netdev,allow_other 0 0

## Now, As you hit the aws s3 bucket, you should see the files that were present in your file system

 ![Alt text](7.png?raw=true "Optional Title")
