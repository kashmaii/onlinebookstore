pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker')
        DOCKER_IMAGE_NAME = "kashmaii/first:tag1"
        // SONAR_URL = "http://40.86.186.123:9000/"
    }

    stages {
        stage('Checkout') {
            steps {
                sh 'echo "Checkout stage passed"'
                git branch: 'master', url: 'https://github.com/kashmaii/onlinebookstore.git'
            }
        }
        
        stage('Build and Test') {
            steps {
                sh 'ls -ltr'
                // build the project and create a JAR file
                sh 'mvn clean package'
            }
        }

        // stage('Static Code Analysis') {
        //     steps {
        //         sh "mvn clean verify sonar:sonar -Dsonar.projectKey='demo' -Dsonar.host.url='${SONAR_URL}' -Dsonar.login=sqp_25cc2a8d230eabbb45e4999cd89e710023ac3e54"
        //     }
        // }

        stage('Build Docker Image') {
            steps {
                // Build Docker image
                script {
                    docker.build(env.DOCKER_IMAGE_NAME)
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                // Login to Docker Hub
                script {
                    docker.withRegistry('https://index.docker.io/v1/', env.DOCKER_HUB_CREDENTIALS) {
                        // Push the Docker image to Docker Hub
                        docker.image(env.DOCKER_IMAGE_NAME).push('latest')
                    }
                }
            }
        }
    }
}
