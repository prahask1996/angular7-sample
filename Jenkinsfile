pipeline {
environment{
    registry = "prahaskattimani/ng7"
    registryCredential ='docker_hub_prahaskattimani'
    dockerImage = ''
  }
 agent any
  stages {
   stage("Install node modules") {
     steps {
       nodejs('nodejs') {
	        sh 'npm install'
          echo "modules installed"
        }
      }
   }
   stage("build") {
     steps {
       nodejs('nodejs') {
			    sh 'npm run ng -- build --prod'
          echo "build successful"
        }
      }
   }
   stage('Approval') {
            // no agent, so executors are not used up when waiting for approvals
            agent none
            steps {
                script {
                    def deploymentDelay = input id: 'Deploy', message: 'Deploy to production?', submitter: 'rkivisto,admin', parameters: [choice(choices: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24'], description: 'Hours to delay deployment?', name: 'deploymentDelay')]
                    sleep time: deploymentDelay.toInteger(), unit: 'HOURS'
                }
            }
        }
	
   stage('build docker image'){
      steps{
        echo "Building docker image"
        script{
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('push docker image'){
      steps{
        echo "pushing docker image"
         script{
           docker.withRegistry( '', registryCredential){
            dockerImage.push()
            dockerImage.push('latest')
           }
        }
      }
    }
     stage('deploy to dev'){
      steps{
        echo "deployeing to dev environment" 
        sh "docker rm -f ng7 || true"
        sh "docker run -d --name=ng7 -p 4200 prahaskattimani/ng7"
      }
    }       
  }
}  
