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
              sh 'terraform output -raw aws_instance_ip >> inventory'
              sshagent(credentials: ['myKey']) {
                echo 'Running Ansible playbook...'
                sh '''
                    ansible-playbook -i inventory playbook.yml
                '''
            }
        }
    }
}
}