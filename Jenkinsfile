pipeline {
    agent { label 'maven' }
    stages{
        stage('Checkout github Initial repository') {
            steps {
                  cleanWs();
                git branch:'main', url:'https://github.com/spring-projects/spring-petclinic.git'
            }
        }
        stage('Unit Testing')
        {
            steps{
                sh '''
                pwd
                /opt/maven/bin/mvn -version
                '''
            }
        }
    }
}
