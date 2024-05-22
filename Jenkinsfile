pipeline {
    agent any 
    tools {
        terraform 'terraform'
    }
    stages {
        stage('Git Checkout') {
            steps {
                script {
                    checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/smarty2900/mdw.git']])
                }
            }
        }
        
        stage('Terraform Init') {
            steps {
                script {
                    withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWS', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWS', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh 'terraform plan'
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    withCredentials([file(credentialsId: 'linuxmachinekey', variable: 'SSH_PRIVATE_KEY')]) {
                        sh 'sudo chown -R jenkins:jenkins ${WORKSPACE}'
                        sh 'sudo chmod -R 755 ${WORKSPACE}'
                        sh 'echo ${SSH_PRIVATE_KEY} > linuxmachinekey.pem'

                    }
                     withCredentials([file(credentialsId: ' MY_SQL', variable: 'mysql')]) {
                        sh 'echo ${mysql} > mysql.yaml'

                    }
                }

                script {
                    withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'AWS', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh 'ls'
                        sh 'chmod 400 linuxmachinekey.pem'
                        sh 'terraform apply --auto-approve'
                        sh 'rm linuxmachinekey.pem'
                    }
                }
            }
        }
    }
}
