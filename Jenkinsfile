podTemplate(
  label: 'build-pod', 
  cloud: 'kubernetes',
  idleMinutes: 5,
  containers: [
    containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true, privileged: true)
  ],
  volumes: [hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock')]) 
{
  node('build-pod') {
    stage('Build') {
      checkout scm

      container('docker') {
        sh 'pwd'
        sh 'ls -R' 
        sh 'ls ..' 
        //sh "docker build -t hello-helm:${env.BUILD_ID} ."
        def img = docker.build("hello-helm:${env.BUILD_ID}")
      }
    }

    stage('Deploy') {
      echo 'deploy...'
    }

  }
}
