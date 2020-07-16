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
    }
    stages {
        stage('Build App') { 
            steps {
                sh 'npm install'
            }
        }
        stage('Build Image') {
            steps {
                sh 'docker build -t mghani828/node-app:'
            }
        }
    }
}
