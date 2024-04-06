pipeline {
    agent any

    environment {
        // Define Docker Hub credentials
        DOCKERHUB_CREDENTIALS = credentials('docker')
        // Define the name of the Docker image
        DOCKER_IMAGE_NAME = "kashmai"
        // Define SonarQube URL (if applicable)
        // SONAR_URL = "http://40.86.186.123:9000/"
    }

    stages {
        // Checkout stage: Check out the code from the Git repository
        stage('Checkout') {
            steps {
                sh 'echo "Checkout stage passed"'
                git branch: 'master', url: 'https://github.com/kashmaii/onlinebookstore.git'
            }
        }
        
        // Build and Test stage: Build and test the project using Maven
        stage('Build and Test') {
            steps {
                sh 'ls -ltr'
                // build the project and create a JAR file
                sh 'mvn clean package'
            }
        }

        // Build Docker Image stage: Build the Docker image
        stage('Build Docker Image') {
            steps {
                // Build Docker image
                script {
                    docker.build(env.DOCKER_IMAGE_NAME)
                }
            }
        }
        
        // Login to Docker Hub stage: Log in to Docker Hub using credentials
        stage('Login to Docker Hub') {         
            steps {                            
                withCredentials([usernamePassword(credentialsId: 'docker', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                    sh "echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin"
                    echo 'Login Completed'                
                }
            }           
        }               
        
        // Push Image to Docker Hub stage: Push the Docker image to Docker Hub
        stage('Push Image to Docker Hub') {         
            steps {                            
                sh 'docker push kashmaii/first:$BUILD_NUMBER'                 
                echo 'Push Image Completed'       
            }           
        }      
    }
}
