pipeline {
    agent any

    stages {
        stage('Terraform Initialize') {
            steps {
                sh '''
                    echo "Initializing Terraform..."
                    terraform init
                '''
            }
        }
        stage('Terraform Apply') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                    sh '''
                        echo "Applying Terraform configuration..."
                        terraform apply -auto-approve
                    '''
                }
            }
        }
        stage('Ansible Playbook') {
            steps {
              script {
                // Clean and create the inventory file with proper format
                sh '''
                  echo "[servers]" > inventory
                  echo "$(terraform output -raw aws_instance_ip) ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/myKey.pem" >> inventory
                '''
              }

              sshagent(credentials: ['myKey']) {
                echo 'Running Ansible playbook...'
                sh '''
                  ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory playbook.yml
                '''
              }
            }
        }
    }
}
