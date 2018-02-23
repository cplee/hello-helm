pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    docker.build("hello-helm:${env.BUILD_ID}")
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}