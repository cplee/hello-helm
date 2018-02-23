pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh "docker build -t hello-helm:${env.BUILD_ID} ."
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}