properties([
    office365ConnectorWebhooks([
        webhook(
            name: 'Teams-Notifications',
            url: 'https://outlook.office.com/webhook/77777777-8888-9999-aaaa-bbbbccccdddd/Jenkins_Alerts', 
            startNotification: true,
            notifySuccess: true,
            notifyFailure: true,
            notifyBackToNormal: true
        )
    ])
])

pipeline {
    agent any
    
    parameters {
        string(name: 'DOCKER_TAG', defaultValue: 'latest', description: 'Тег для Docker образу')
    }

    stages {
        stage('Start') {
            steps {
                echo "Lab_3: starting build for version ${params.DOCKER_TAG}"
            }
        }
        
        stage('Check environment') {
            steps {
                echo 'Перевірка середовища...'
                sh 'docker version'
            }
        }

        stage('Image build') {
            steps {
                // Використовуємо параметр DOCKER_TAG
                sh "docker build -t prikm:${params.DOCKER_TAG} ."
                sh "docker tag prikm yuriipryimak/prikm:${params.DOCKER_TAG}"
                sh "docker tag prikm yuriipryimak/prikm:latest"
            }
        }

        stage('Push to registry') {
            steps {
                withDockerRegistry([ credentialsId: "228", url: "" ]) {
                    sh "docker push yuriipryimak/prikm:${params.DOCKER_TAG}"
                    sh "docker push yuriipryimak/prikm:latest"
                }
            }
        }

        stage('Deploy image'){
            steps{
                sh 'docker rm -f my-website-container || true'
                sh "docker run -d -p 8082:80 --name my-website-container yuriipryimak/prikm:${params.DOCKER_TAG}"
            }
        }
    }
}
