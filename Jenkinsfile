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
        stage ('Deploy') {
            steps{
                sshagent(credentials : ['ec2-deploy']) {
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@ec2-52-87-217-26.compute-1.amazonaws.com uptime'
                    sh "ssh -v ubuntu@ec2-52-87-217-26.compute-1.amazonaws.com << EOF
                            docker pull $registry:$BUILD_NUMBER;
                            docker run -d --name=node-app -p 3000:3000 $registry:$BUILD_NUMBER;
                            exit;
                        EOF"
                    // sh "docker pull $registry:$BUILD_NUMBER"
                    // sh "docker run -d --name=node-app -p 3000:3000 $registry:$BUILD_NUMBER"
                    // sh "exit"
                }
            }
        }
        stage('Cleaning Up') {
            steps {
                sh "docker rmi $registry:$BUILD_NUMBER"
            }
        }
    }
}
