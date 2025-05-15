#!/bin/bash
yum update -y
yum install -y httpd git

# Create the directory and fetch the app
mkdir -p /var/www/html
cd /var/www/html
git clone https://github.com/abhi891009/terraform-2tier.git
cd my_app
mv index.php /var/www/html/
# Start Apache service
systemctl restart httpd
