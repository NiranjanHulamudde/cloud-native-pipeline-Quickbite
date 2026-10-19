pipeline {
    agent any
    
    environment {
        
        DOCKER_HUB_USER = 'niranjanhulamudde'
        IMAGE_NAME      = 'cloud-native-app'
        DOCKER_CREDS    = 'docker-pass' 
    }
    
    stages {
        stage('Checkout Code') {
            steps {
                
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                script {
                    def commitHash = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
                    sh "docker build -t ${DOCKER_HUB_USER}/${IMAGE_NAME}:${commitHash} ."
                    sh "docker build -t ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest ."
                }
            }
        }
        
        stage('Ship to Docker Hub') {
            steps {
                echo 'Logging into Docker Hub and pushing image...'
                
                withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDS}", usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh "echo ${PASS} | docker login -u ${USER} --password-stdin"
                    
                    script {
                        def commitHash = sh(script: "git rev-parse --short HEAD", returnStdout: true).trim()
                        sh "docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:${commitHash}"
                        sh "docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest"
                    }
                }
            }
        }
    }
    
    post {
        always {
            echo 'Cleaning up local pipeline build images to save disk space...'
            sh "docker logout"
        }
    }
}

