provider "aws" {
  region = "ap-southeast-2"
}

# Define a launch configuration
resource "aws_launch_configuration" "test-terra-ec2" {
  name = "terra-ec2-launch-configuration"
  image_id = var.image_id  

  instance_type = var.instance_type
  key_name = var.key_name  

  lifecycle {
    create_before_destroy = true
  }
}

# Define an auto scaling group
resource "aws_autoscaling_group" "ec2-terra-asg" {
  desired_capacity     = 1
  max_size             = 2
  min_size             = 1
  vpc_zone_identifier = [var.subnet_id]  # Replace with your subnet ID

  launch_configuration = aws_launch_configuration.test-terra-ec2.id

  health_check_type          = "EC2"
  health_check_grace_period  = 300
  force_delete               = true
  wait_for_capacity_timeout = "0"
}

# Define an auto scaling policy
resource "aws_autoscaling_policy" "ec2-terra-asg-policy" {
  name                   = "scale_up"
  scaling_adjustment    = 1
  adjustment_type       = "ChangeInCapacity"
  cooldown              = 300
  autoscaling_group_name = aws_autoscaling_group.ec2-terra-asg.name
}