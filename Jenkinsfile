pipeline {
    agent { label 'maven' }
    stages{
        stage('Checkout github Initial repository') {
            steps {
                  cleanWs()
                git branch:'main', 'https://github.com/spring-projects/spring-petclinic.git'
            }
        }
    }
}
