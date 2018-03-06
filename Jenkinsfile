node {
  def registry = 'toolchain-docker-registry:5000'
  def clair = 'toolchain-clair:6060'
  def app = 'hello-helm'
  def commitHash = checkout(scm).GIT_COMMIT

  stage('Build') {
    container('docker') {
      sh "docker build -t ${registry}/${app}:${commitHash} ."
    }
    container('skopeo') {
      sh "skopeo --insecure-policy copy --dest-tls-verify=false docker-daemon:${registry}/${app}:${commitHash} docker://${registry}/${app}:${commitHash}"
    }
  }

  stage('SAST') {
    container('reg') {
      sh "reg --insecure --registry https://${registry} vulns --clair http://${clair} ${app}:${commitHash}"
    }
  }

  stage('Deploy') {
    container('helm') {
      def vals = "image.tag=${commitHash},image.repository=localhost:30500/${app}"
      try {
        sh "helm get ${app}"
        sh "helm upgrade ${app} ${app}-chart --set ${vals}"
      } catch (Exception e) {
        sh "helm install ${app}-chart -n ${app} --set ${vals}"
      }
    }
  }

  stage('Test') {
    container('goss') {
      sh "goss validate --no-color --retry-timeout 60s"
    }
  }

}
