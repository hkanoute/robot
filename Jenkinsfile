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
        def totalTests = testResults.count('<test id=')
        def passedTests = testResults.count('status="PASS"')
        def failedTests = totalTests - passedTests

        def tagPattern = /<tag>(.*?)<\/tag>/
        def tags = []
        testResults.eachMatch(tagPattern) { match ->
            tags << match[1]
        }
        def uniqueTags = tags.unique().join(', ')

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
            },
            {
            "name": "Tags",
            "value": "${uniqueTags}",
            "inline": false
            },
            {
            "name": "Pose pas de question sur le -6",
            "value": "jsp",
            "inline": false
            }
            
            ],
            "image": {
              "url": "https://images-ext-1.discordapp.net/external/QjUNVja7_lHd7TMUY7MebpNw_pCqUJz3K36DfVTtW6Y/https/media.tenor.com/ctRaCU2Now8AAAPo/akira-job-application.mp4"
            }
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