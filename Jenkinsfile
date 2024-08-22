pipeline {
    agent { label 'maven' }
    stages{
        stage('Checkout github Initial repository') {
            steps {
                  cleanWs();
                git branch:'main', url:'https://github.com/spring-projects/spring-petclinic.git'
            }
        }
    }
}
