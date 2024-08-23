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
                /opt/maven/bin/mvn test
                '''
            }
        }
        stage('Package Build'){
            steps{
                sh '''
                    /opt/maven/bin/mvn clean install --DskipTests
                '''
            }
        }
        stage('Trivy Testing'){
            steps{
                sh '''
                    trivy -fs targets/*.war
                '''
            }
        }
    }
}
