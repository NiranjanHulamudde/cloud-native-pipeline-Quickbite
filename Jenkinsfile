pipeline {
    agent any
    
    environment {
        // Docker Configuration
        DOCKER_HUB_USER = 'niranjanhulamudde' 
        IMAGE_NAME      = 'cloud-native-app'
        DOCKER_CREDS    = 'docker-pass'
        
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_DEFAULT_REGION    = 'us-east-1' 
    }
    
    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    
                    ENV_COMMIT_HASH = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
                    sh "docker build -t ${DOCKER_HUB_USER}/${IMAGE_NAME}:${ENV_COMMIT_HASH} ."
                    sh "docker build -t ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest ."
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDS}", usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh "echo ${PASS} | docker login -u ${USER} --password-stdin"
                    sh "docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:${ENV_COMMIT_HASH}"
                    sh "docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest"
                }
            }
        }
        
        
        stage('Terraform Apply Network') {
            steps {
                dir('terraform') { 
                    echo 'Initializing Terraform...'
                    sh 'terraform init'
                    
                    echo 'Planning infrastructure changes...'
                    sh 'terraform plan'
                    
                    echo 'Applying infrastructure updates...'
                    
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
    
    post {
        always {
            echo 'Cleaning up environment...'
            sh "docker logout"
        }
    }
}
