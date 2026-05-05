pipeline {
agent any
stages {
stage('Start') {
steps {
echo 'Lab_2: started by GitHub'
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
withDockerRegistry([ credentialsId: "228", url: "" ])

{

sh "docker push yuriipryimak/prikm:latest"
sh "docker push yuriipryimak/prikm:$BUILD_NUMBER"
}
}
}
stage('Deploy image'){
steps{
sh "docker run -d -p 80:80 yuriipryimak/prikm"
}
}
}
}
