# Deploy Website with Jenkins and Terraform

This project demonstrates how to automatically deploy a static website to an EC2 instance using **Jenkins**, **Terraform**, and **Ansible**. It combines Infrastructure as Code (IaC) and CI/CD practices to provision infrastructure, configure the server, and deploy the application.

## 🚀 Project Overview

- **Terraform** is used to provision AWS infrastructure (e.g., EC2 instance, VPC, Subnet).
- **Ansible** configures the EC2 instance (e.g., installing web server, copying files).
- **Jenkins** automates the CI/CD pipeline.
- The pipeline deploys a static `index.html` page with an animated GIF.
