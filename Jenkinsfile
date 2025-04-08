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
                }

            }

        }
        stage('Discord notification') {
            steps {
            script {
                def testResults = readFile('output.xml')
                def totalTests = testResults.count('<testcase')
                def failedTests = testResults.count('<failure')
                def passedTests = totalTests - failedTests

                def discordPayload = """
                {
                "embeds": [{
                    "title": "Test Results",
                    "color": 3066993,
                    "fields": [
                    {
                        "name": "Total Tests",
                        "value": "${totalTests}",
                        "inline": true
                    },
                    {
                        "name": "Passed",
                        "value": "${passedTests}",
                        "inline": true
                    },
                    {
                        "name": "Failed",
                        "value": "${failedTests}",
                        "inline": true
                    }
                    ]
                }]
                }
                """

                writeFile file: 'discordPayload.json', text: discordPayload
                bat 'curl -H "Content-Type: application/json" -X POST --data @discordPayload.json https://discordapp.com/api/webhooks/1359154405147934992/2RwoZD57gNSStkB8yxAUT4O7jAe7OOAECZTCuMj9tDW6RBHYUaCjgon1E05MoTjsaQlg'
            }
            }
        }
    }
}