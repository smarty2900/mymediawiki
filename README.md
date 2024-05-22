# MediaWiki Deployment using Terraform and Ansible with Jenkins

This repository contains the necessary scripts and configuration files to deploy a MediaWiki application on AWS using Terraform for infrastructure provisioning and Ansible for configuration management. The deployment is orchestrated using Jenkins for continuous integration and continuous deployment (CI/CD).

## Prerequisites

Before you begin, ensure you have the following installed and configured:

- [Terraform](https://www.terraform.io/downloads)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [Jenkins](https://www.jenkins.io/doc/book/installing/)
- AWS account and AWS CLI configured with appropriate permissions

## Repository Structure

- **ansible**: Contains Ansible playbook and related configuration files.
- **terraform**: Contains Terraform configuration files.
- **Jenkinsfile**: Jenkins pipeline script for CI/CD integration.
- **README.md**: This file.

## Jenkins Global Credentials

### AWS Key Pair

1. Create a new key pair in AWS IAM Management Console.
2. Save the private key as a secret file.
3. Add the secret file to Jenkins global credentials with an ID, e.g., `aws-private-key`.

### MySQL YAML File

1. Upload the `mysql.yaml` file as a secret file in Jenkins global credentials.
2. Add the secret file to Jenkins global credentials with an ID, e.g., `mysql-config`.

## Deployment Steps

1. **Clone the Repository**: Clone this repository to your local machine.

2. **Configure Jenkins**: Set up Jenkins on your server and configure it to access your repository.

3. **Set Up Jenkins Pipeline**: Create a new pipeline job in Jenkins and configure it to use the provided `Jenkinsfile` as the pipeline script.

4. **Run Jenkins Pipeline**: Trigger the Jenkins pipeline to start the deployment process.

5. **Monitor Deployment**: Monitor the Jenkins build logs to track the progress of the deployment.

6. **Access MediaWiki**: Once deployment is complete, access MediaWiki through the provided URL or EC2 instance's public IP.

## Cleanup

To clean up the resources provisioned by Terraform, run `terraform destroy` from the `terraform` directory as part of the Jenkins pipeline or manually trigger it when needed.

## Contributing

Contributions to this project are welcome. Feel free to open issues for any questions or suggestions, or submit pull requests for improvements. Let's make deploying MediaWiki with Terraform and Ansible on Jenkins a smoother experience for everyone!
