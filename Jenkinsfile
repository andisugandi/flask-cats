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
                sh "python -m venv .venv && . .venv/bin/activate && pip install -r requirements.txt && python ${WORKSPACE}/test.py"
            }
        }
	stage('Manual Approval') {
            steps {
                input message: "Lanjutkan ke tahap Deploy?"
            }
        }
        stage('Deploy') {
            steps {
                script {
                    docker.withRegistry('https://quay.io', 'quay-credentials') {
                        sh "docker image push quay.io/andidotsugandi/flaskcats"
                        sh "docker container run -d --name kucing -p 5000:5000 quay.io/andidotsugandi/flaskcats"
                        sleep(time: 1, unit: 'MINUTES')
                        sh "docker container stop kucing && docker container rm kucing"
                    }
                }
            }
        }
    }
}
