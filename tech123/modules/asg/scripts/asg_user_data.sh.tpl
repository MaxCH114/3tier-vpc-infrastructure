#!/bin/bash

# Update system packages
yum update -y

# Install Apache HTTP server
yum install -y httpd

# Start and enable Apache service
systemctl start httpd
systemctl enable httpd

# Create a default web page displaying the instance's private IP address
cat <<EOF | sudo tee /var/www/html/index.html
<html>
  <head><title>Welcome</title></head>
  <body>
    <h1>Hello from $(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)</h1>
  </body>
</html>
EOF

# Create a simple health check endpoint
cat <<EOF | sudo tee /var/www/html/health
OK
EOF

# Make sure the health endpoint has the correct permissions
chmod 644 /var/www/html/health

# Restart Apache to apply changes
systemctl restart httpd