node {
  stage('Build') {
    def commitHash = checkout(scm).GIT_COMMIT

    container('docker') {
      def tag = "cplee/hello-helm:${commitHash}"
      sh "docker build -t ${tag} ."
      //sh "docker push ${tag}"
    }
  }

  stage('Deploy') {
    echo 'deploy...'
  }

}
