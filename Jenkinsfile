pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    docker.build('my-app')
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    docker.image('my-app').inside {
                        sh 'python -m unittest discover'
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig', variable: 'KUBECONFIG')]) {
                    sh 'kubectl apply -f kubernetes-manifest.yaml'
                }
            }
        }
    }
}
