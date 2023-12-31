pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh "docker build . --file Dockerfile -t quay.io/andidotsugandi/flaskcats:latest"
                sh "docker image ls"
            }
        }
        stage("Test"){
            agent { docker { image 'python:3.12.1' } }
            steps{
                sh "pip install -r requirements.txt && python ${WORKSPACE}/test.py"
            }
        }
        stage('Deploy') {
            steps {
                script {
                    withDockerRegistry(credentialsId: '8ba027e5-6193-404c-9645-f19e799d492d', toolName: 'docker') {
                        sh "docker image push quay.io/andidotsugandi/flaskcats"
                        sh "docker container run -d --name kucing -p 5000:5000 quay.io/andidotsugandi/flaskcats"
                    }
                }
            }
        }
    }
}
