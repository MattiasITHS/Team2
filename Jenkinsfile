pipeline {
    agent any
    stages {
        stage('Build API') {
           steps {
               sh "cd spring-petclinic-rest && nohup mvn spring-boot:run &"
               sleep(20)
           }
        }
         stage('Build Website') {
            steps {
               sh 'cd spring-petclinic-angular/static-content && curl https://jcenter.bintray.com/com/athaydes/rawhttp/rawhttp-cli/1.0/rawhttp-cli-1.0-all.jar -o rawhttp.jar && nohup java -jar ./rawhttp.jar serve . -p 4200 &'  
                sleep(3)
                  }
           }
      
         stage('Postman testing') {
            steps { 
                script {
                    try {
                       sh 'newman run API_test/PetMain.postman_collection.json --environment API_test/PetE.postman_environment.json --reporters cli,junit --reporter-junit-export "myreport.xml"'
                    } catch (Exception e) {
                        echo "Tests are failing, continue pipeline..."
                    } 
                }
            }
             post {
                 always {
                     junit '**/*.xml'
                 }
             }
        }
        
         stage('Build JUnit') {
            steps {
                sh 'cd spring-petclinic-rest && mvn compile &'

            }
        }
        
        stage('Robot Framework System tests with Selenium') {
            steps {
                sh 'robot --variable BROWSER:headlesschrome -d Robot_tests/Results Robot_tests/Tests'
            }
            post {
                always {
                    script {
                          step(
                                [
                                  $class              : 'RobotPublisher',
                                  outputPath          : 'Robot_tests/Results',
                                  outputFileName      : '**/output.xml',
                                  reportFileName      : '**/report.html',
                                  logFileName         : '**/log.html',
                                  disableArchiveOutput: false,
                                  passThreshold       : 50,
                                  unstableThreshold   : 40,
                                  otherFiles          : "**/*.png,**/*.jpg",
                                ]
                          )
                    }
                }
            }
        }
        
    }
    post {
        always {   
            notifyBuild(currentBuild.result)
            
        }
    }
}

def notifyBuild(String buildStatus = 'STARTED') {
  // build status of null means successful
  buildStatus = buildStatus ?: 'SUCCESS'

  // Default values
  def colorName = 'RED'
  def colorCode = '#FF0000'
  def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
  def summary = "${subject} (${env.BUILD_URL})"
  def details = """STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':
    Check console output at '${env.BUILD_URL}'"""

  // Override default values based on build status
  if (buildStatus == 'STARTED') {
    color = 'YELLOW'
    colorCode = '#FFFF00'
  } else if (buildStatus == 'SUCCESS') {
    color = 'GREEN'
    colorCode = '#00FF00'
  } else {
    color = 'RED'
    colorCode = '#FF0000'
  }
  
  emailext (
            subject: subject,
            body: details,
            to: 'jenkins.iths.mailer@gmail.com')
}
