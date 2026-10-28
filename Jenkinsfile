def ENV_COMMIT_HASH = ""

pipeline {
    agent any
    
    environment {

        DOCKER_HUB_USER = 'niranjanhulamudde' 
        DOCKER_CREDS    = 'docker-pass'
        

        API_IMAGE  = 'quickbite-backend'
        UI_IMAGE   = 'quickbite-frontend'
        ADM_IMAGE  = 'quickbite-admin'
        
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
        
        stage('Build QuickBite Images') {
            steps {
                script {
                    ENV_COMMIT_HASH = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
                    
                    echo "Compiling Backend API Image layer..."
                    sh "docker build --build-arg NODE_OPTIONS='--max-old-space-size=512' -t ${DOCKER_HUB_USER}/${API_IMAGE}:${ENV_COMMIT_HASH} -t ${DOCKER_HUB_USER}/${API_IMAGE}:latest ./Backend"
                    
                    echo "Compiling Frontend UI Web Image layer..."
                    sh "docker build --build-arg NODE_OPTIONS='--max-old-space-size=512' -t ${DOCKER_HUB_USER}/${UI_IMAGE}:${ENV_COMMIT_HASH} -t ${DOCKER_HUB_USER}/${UI_IMAGE}:latest ./Frontend"
                    
                    echo "Compiling Admin Management Dashboard Image layer..."
                    sh "docker build --build-arg NODE_OPTIONS='--max-old-space-size=512' -t ${DOCKER_HUB_USER}/${ADM_IMAGE}:${ENV_COMMIT_HASH} -t ${DOCKER_HUB_USER}/${ADM_IMAGE}:latest ./Admin"
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDS}", usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh "echo ${PASS} | docker login -u ${USER} --password-stdin"
                    
                    echo "Shipping compiled infrastructure images to Docker Hub registry..."
                   
                    sh "docker push ${DOCKER_HUB_USER}/${API_IMAGE}:${ENV_COMMIT_HASH}"
                    sh "docker push ${DOCKER_HUB_USER}/${API_IMAGE}:latest"
                    
                   
                    sh "docker push ${DOCKER_HUB_USER}/${UI_IMAGE}:${ENV_COMMIT_HASH}"
                    sh "docker push ${DOCKER_HUB_USER}/${UI_IMAGE}:latest"
                    
                   
                    sh "docker push ${DOCKER_HUB_USER}/${ADM_IMAGE}:${ENV_COMMIT_HASH}"
                    sh "docker push ${DOCKER_HUB_USER}/${ADM_IMAGE}:latest"
                }
            }
        }
        
        stage('Terraform Apply Network') {
            steps {
                dir('terraform') { 
                    echo 'Initializing cloud environment'
                    sh 'terraform init'
                    
                    echo 'Generating cloud dependency delta metrics...'
                    sh 'terraform plan'
                    
                    echo 'Executing AWS live updates layer apply...'
                    sh "terraform apply -var='env_commit_hash=${ENV_COMMIT_HASH}' -auto-approve"
                }
            }
        }
    }
    
    post {
        always {
            sh "docker logout"
        }
    }
}
