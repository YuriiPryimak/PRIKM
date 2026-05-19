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
