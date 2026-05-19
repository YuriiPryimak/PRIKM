pipeline {
    agent any
    
    // Цей блок активує кнопку "Build with Parameters"
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
                sh 'docker version'
            }
        }

        stage('Image build') {
            steps {
                sh "docker build -t prikm:${params.DOCKER_TAG} ."
                sh "docker tag prikm yuriipryimak/prikm:${params.DOCKER_TAG}"
            }
        }

        stage('Push to registry') {
            steps {
                // Використовуйте свій ID credentials (у вас був 228)
                withDockerRegistry([ credentialsId: "228", url: "" ]) {
                    sh "docker push yuriipryimak/prikm:${params.DOCKER_TAG}"
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
