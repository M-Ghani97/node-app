pipeline {
    agent {
        docker {
            image 'node:12'
            args '-p 3000:3000' 
        }
    }
    stages {
        stage('Build') { 
            steps {
                sh 'sudo npm install -g eslint --unsafe-perm=true --allow-root' 
                sh 'npm install'
            }
        }
    }
}
