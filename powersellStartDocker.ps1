docker-compose up -d jenkins-blueocean
$process = Start-Process -FilePath "docker-compose" -ArgumentList "build" -Wait -PassThru
Write-Host "Build process finished with exit code: $($process.ExitCode)"

if ($process.ExitCode -eq 0) {
    Write-Host "Build completed successfully."
} else {
    Write-Host "Build failed with exit code $($process.ExitCode)."
}

Write-Host "Attempting to retrieve initial admin password..."

docker exec devops_arch_docker_01-jenkins-1 cat /var/jenkins_home/secrets/initialAdminPassword
