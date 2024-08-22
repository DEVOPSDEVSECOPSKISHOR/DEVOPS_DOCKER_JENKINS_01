docker-compose up -d 
$process = Start-Process -FilePath "docker-compose" -ArgumentList "build" -Wait -PassThru
Write-Host "Build process finished with exit code: $($process.ExitCode)"

if ($process.ExitCode -eq 0) {
    Write-Host "Build completed successfully."
} else {
    Write-Host "Build failed with exit code $($process.ExitCode)."
}

Write-Host "Attempting to retrieve initial admin password..."

Start-Sleep -Seconds 10

docker exec devops_arch_docker_01-jenkins-1 cat /var/jenkins_home/secrets/initialAdminPassword
