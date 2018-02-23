pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                kubernetes {
                    buildImage(name: "hello-helm:${env.BUILD_ID}")
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