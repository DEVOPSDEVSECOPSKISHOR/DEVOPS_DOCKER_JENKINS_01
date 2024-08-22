pipeline {
    agent 'maven'
    stages{
        stage('Checkout github Initial repository') {
            cleanWs()
            steps {
                git 'https://github.com/spring-projects/spring-petclinic.git'
            }
        }
    }
}
