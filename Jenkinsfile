pipeline {
  environment {
    registry = "ankababu/web"
    registryCredential = 'docker-hub'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/ankababug/webapp-1.git'
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('deploy to k8s') {
      steps{
        sshagent(['kops-machine']){
          sh "scp -o StrictHostKeyChecking=no newpod.yml centos@172.31.39.237:/home/centos/"
          script{
              try{
                 sh "ssh centos@172.31.39.237 kubectl apply -f ."
              }catch(error){
                 sh "ssh centos@172.31.39.237 kubectl create -f ."
              }
           }
        }
      }
    }
  }
}
