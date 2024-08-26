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
                    trivy fs --scanners vuln --format json -o scan_results.json target/spring-petclinic-3.3.0-SNAPSHOT.jar
                    trivy convert --format template --template "@/app/contrib/html.tpl" scan_results.json > scan_results.html
                '''
            }
        }
        stage('Publish artifact'){
            steps{
                publishHTML target: [
            allowMissing: false,
            alwaysLinkToLastBuild: false,
            keepAll: true,
            reportDir: '.',
            reportFiles: 'scan_results.html',
            reportName: 'RCov Report'
          ]
            }
        }
    }
}
