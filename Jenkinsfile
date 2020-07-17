prevBuild = BUILD_NUMBER.toInteger() - 1;
pipeline {
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
                    sh 'ssh -o StrictHostKeyChecking=no ubuntu@ec2-54-90-29-225.compute-1.amazonaws.com uptime'
                    sh "ssh -v ubuntu@ec2-54-90-29-225.compute-1.amazonaws.com 'docker stop $registry:$prev_BUILD && docker rm $registry:$prev_BUILD && docker pull $registry:$BUILD_NUMBER && docker run -d --name=node-app-$BUILD_NUMBER -p 3000:3000 $registry:$BUILD_NUMBER'"
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
