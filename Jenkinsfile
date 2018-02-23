podTemplate(label: 'build-pod', cloud: 'kubernetes',
  containers: [
    containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true, privileged: true)
  ],
  volumes: [hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock')]) 
{
  node('build-pod') {

    stage('Build') {
      def img = docker.build("hello-helm:${env.BUILD_ID}")
    }

    stage('Deploy') {
      echo 'deploy...'
    }

  }
}
