#!/bin/bash
    # UserData for Amazon Linux 2023
    
    # Update system packages
    yum update -y

    # Install Nginx
    yum install nginx -y

    # Start Nginx service
    systemctl start nginx

    # Enable Nginx service to start on boot
    systemctl enable nginx

    # Web Server Document Root Path
    document_root="/usr/share/nginx/html"
