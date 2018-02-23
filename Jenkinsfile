pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                buildImage(name: "hello-helm:${env.BUILD_ID}")
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}