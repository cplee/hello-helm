node {
  def imageRepo = 'cplee/hello-helm'
  def nodePort = 30000
  def helmRelease = 'hello-helm'
  def commitHash = checkout(scm).GIT_COMMIT

  stage('Build') {
    container('docker') {
      sh "docker build -t ${imageRepo}:${commitHash} ."
    }
  }

  stage('SAST') {
    container('reg') {
      sh "reg vulns --clair http://toolchain-clair:6060 ${imageRepo}:${commitHash}"
    }
  }

  stage('Deploy') {
    container('helm') {
      def vals = "image.tag=${commitHash},image.repository=${imageRepo},service.type=NodePort,service.nodeport=${nodePort}"
      try {
        sh "helm get ${helmRelease}"
        sh "helm upgrade ${helmRelease} hello-helm-chart --set ${vals}"
      } catch (Exception e) {
        sh "helm install hello-helm-chart -n ${helmRelease} --set ${vals}"
      }
    }
  }

  stage('Test') {
    container('jnlp') {
      sh "curl -s http://hello-helm | grep 'Automation for the People'"
    }
  }

}
