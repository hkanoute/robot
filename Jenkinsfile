pipeline {
    agent any


  environment {
        JIRA_ID    = credentials('JIRA_IDS')

    }
    stages {
      stage('Curl') {
  steps {
      bat 'curl -H "Content-Type: application/json" -X POST --data "{ \\"client_id\\": \\"%JIRA_ID_USR%\\",\\"client_secret\\": \\"%JIRA_ID_PSW%\\" }"  https://xray.cloud.getxray.app/api/v2/authenticate >token.txt'}
      }
        stage('Test'){
            steps{
                bat 'robot first.robot'

            }
            post {
                always {
                    bat """
                        set /p TOKEN=<token.txt
                        curl -H "Content-Type: text/xml" -X POST -H "Authorization: Bearer %TOKEN%" ^
                        --data @"output.xml" https://xray.cloud.getxray.app/api/v2/import/execution/robot?projectKey=POEI20252
                    """
                    cleanWs()
                }

            }

        }
        stage('Discord notification') {
            steps {
                bat 'curl -H "Content-Type: application/json" -X POST --data "{\\"content\\":\\"Test completed\\"}" https://discordapp.com/api/webhooks/1359154405147934992/2RwoZD57gNSStkB8yxAUT4O7jAe7OOAECZTCuMj9tDW6RBHYUaCjgon1E05MoTjsaQlg'
            }
        }
    }
}