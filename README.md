# my-first-devops-project

## Introduction
This is my first DevOps project where I try to deploy my static site. Visit https://www.cheeseong-luan.dev/ to see my deployed portfolio site.

## Tech Stack
- IaC and Infrastructure Provisioning: **Terraform**
- Deployment and Configuration Management: **Ansible**
- Cloud Platform and Server: **AWS**
- Static Site Generator: **Hugo**
- Web server: **Nginx**
- CI/CD: **GitHub Actions**

## Things to be done
- [x] Terraform IaC
    - [x] Instance
    - [x] Security Group
    - [x] VPC
    - [x] Terraform Cloud
    - [x] Elastic IP for static public IP

- [x] Hugo
    - [x] Customise portfolio site

- [x] Domain
    - [x] Get a domain (cheeseong-luan.dev)
    - [x] Add DNS record on registrar to point to provisioned EIP

- [x] Configure nginx server
    - [x] Set up Certbot
        - [x] Get a SSL Cert
        - [x] Automate SSL renewal
    - [x] Point DNS record to EIP
    - [x] Ensure https://cheeseong-luan.dev works

- [x] Ansible
    - [x] Set up Inventory
    - [x] Set up Playbook
        - [x] Synchronise built site to server
        - [x] Change ownership to nginx

- [x] GitHub Actions
    - [x] Write CI/CD workflow / pipeline
        - [x] Build stage
            - [x] Set up and build Hugo site with hugo commands
            - [x] Store/Upload built site as artifact on GitHub

        - [x] Deploy stage
            - [x] Set up ansible
            - [x] Use repository secret to interact with server
            - [x] Run ansible playbook to deploy

    - [x] Store Ansible secrets as repository secret