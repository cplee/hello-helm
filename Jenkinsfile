node {
  def imageRepo = 'cplee/hello-helm'
  def nodePort = 30000
  def helmRelease = 'hello-helm'
  def commitHash = checkout(scm).GIT_COMMIT

  stage('Build') {
    container('docker') {
      def tag = "${imageRepo}:${commitHash}"
      sh "docker build -t ${tag} ."
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
    container {
      sh "curl -s http://hello-helm | grep "Automation for the People"
    }
  }

}
