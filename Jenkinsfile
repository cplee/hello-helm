node {
  def app = 'hello-helm'
  def commitHash = checkout(scm).GIT_COMMIT

  stage('Build') {
    container('docker') {
      sh "docker build -t ${app}:${commitHash} ."
    }
    container('skopeo') {
      sh "skopeo --insecure-policy copy --dest-tls-verify=false docker-daemon:${app}:${commitHash} docker://toolchain-docker-registry:5000/${app}:${commitHash}"
    }
  }

  stage('SAST') {
    container('klar') {
      #sh "reg --insecure --registry https://toolchain-docker-registry:5000 vulns --clair http://toolchain-clair:6060 ${app}:${commitHash}"
      # sh "clair-scanner --ip=toolchain-docker-registry --clair=http://toolchain-clair:6060 ${$app}:${commitHash}"
      sh "REGISTRY_INSECURE=true CLAIR_ADDR=toolchain-clair /klar toolchain-docker-registry.default.svc.cluster.local:5000/${app}:${commitHash}"

    }
  }

  stage('Deploy') {
    container('helm') {
      def vals = "image.tag=${commitHash},image.repository=127.0.0.1:30500/${app}"
      try {
        sh "helm get ${app}"
        sh "helm upgrade ${app} ${app}-chart --wait --set ${vals}"
      } catch (Exception e) {
        sh "helm install ${app}-chart -n ${app} --wait --set ${vals}"
      }
    }
  }

  stage('Test') {
    container('goss') {
      sh "goss validate --no-color --retry-timeout 60s"
    }
  }

}
