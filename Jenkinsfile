properties([
    office365ConnectorWebhooks([
        webhook([
            name: 'Teams-0365',
            url: 'https://outlook.office.com/webhook/a1b2c3d4-e5f6-7890-abcd-ef1234567890/IncomingWebhook/1234567890abcdef/987654321'
            startNotification: true,
            notifySuccess: true,
            notifyFailure: true,
            notifyBackToNormal: true,
            timeout: 30000
        ])
    ])
])

pipeline {
    agent any
    stages {
        stage('Start') {
            steps {
                echo 'Lab_2: started by GitHub'
            }
        }
        
        stage('Check environment') {
            steps {
                echo 'Перевірка версії Docker перед збіркою...'
                sh 'docker version'
            }
        }

        stage('Image build') {
            steps {
                sh "docker build -t prikm:latest ."
                sh "docker tag prikm yuriipryimak/prikm:latest"
                sh "docker tag prikm yuriipryimak/prikm:$BUILD_NUMBER"
            }
        }
        stage('Push to registry') {
            steps {
                withDockerRegistry([ credentialsId: "228", url: "" ]) {
                    sh "docker push yuriipryimak/prikm:latest"
                    sh "docker push yuriipryimak/prikm:$BUILD_NUMBER"
                }
            }
        }
        stage('Deploy image'){
            steps{
                sh 'docker rm -f my-website-container || true'
                sh 'docker run -d -p 8082:80 --name my-website-container yuriipryimak/prikm:latest'
            }
        }
    }
}
