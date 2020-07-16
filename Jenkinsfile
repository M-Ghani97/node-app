pipeline {
    // agent {
    //     docker {
    //         image 'node:12'
    //         args '-p 3000:3000' 
    //     }
    // }
    agent any
    environment {
        HOME = '.'
        registry = 'mghani828/node-app'
        registryCredential = 'docker-hub'
        dockerImage = ''
    }
    stages {
        stage('Build App') { 
            steps {
                sh 'npm install'
            }
        }
        stage('Build Image') {
            steps {
                // sh "docker build -t mghani828/node-app:${BUILD_NUMBER}"
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage('Push Image') {
            steps {
                // sh "docker push mghani828/node-app:${BUILD_NUMBER}"
                script {
                    docker.withRegistry( '', registryCredential ) {
                    dockerImage.push()
                    }
                }
            }
        }
    }
}
