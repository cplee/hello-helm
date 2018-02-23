pipeline {
    agent {
        kubernetes {
            label 'build-pod'
            containerTemplate {
                name 'docker'
                image 'docker'
                ttyEnabled true
                command 'cat'
            }
            hostPathVolume {
                mountPath '/var/run/docker.sock'
                hostPath '/var/run/docker.sock'
            }
        }
    }

    stages {
        stage('Build') {
            steps {
                container('docker') {
                    sh "docker build hello-helm:${env.BUILD_ID} ."
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
