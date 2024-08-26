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
                    /opt/maven/bin/mvn -DskipTests clean install
                '''
            }
        }
        stage('Trivy Testing'){
            steps{
                sh '''
                    trivy fs --format json -o scan_results.json .
                    trivy convert --format template --template "@contrib/html.tpl" scan_results.json > scan_results.html
                '''
            }
        }
        stage('Publish artifact'){
            steps{
                publishHTML target: [
            allowMissing: false,
            alwaysLinkToLastBuild: false,
            keepAll: true,
            reportDir: 'coverage',
            reportFiles: 'scan_results.html',
            reportName: 'RCov Report'
          ]
            }
        }
    }
}
