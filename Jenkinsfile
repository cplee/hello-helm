podTemplate( label: 'build-pod', cloud: 'kubernetes', idleMinutes: 5,
  containers: [ containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true, privileged: true) ],
  volumes: [hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock')]) 
{
  node('build-pod') {
    stage('Build') {
      checkout scm

      container('docker') {
        def tag = "toolchain-docker-registry/hello-helm:${env.GIT_COMMIT}"
        sh "docker build -t ${tag} ."
        sh "docker push ${tag}"
      }
    }

    stage('Deploy') {
      echo 'deploy...'
    }

  }
}
