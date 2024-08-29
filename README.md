# Docker Environment Setup and SSH Server

This repository contains two key components: a PowerShell script to automate Docker environment setup and a Dockerfile to create an SSH server within a Docker container.

## PowerShell Script for Docker Environment Setup and Build

This PowerShell script is designed to automate the process of setting up a Docker environment, building the Docker containers, and retrieving the initial Jenkins admin password.

### Step-by-Step Breakdown of the Script:

#### 1. Starting Docker Containers

The script starts by running the Docker containers in detached mode using the `docker-compose up -d` command. This ensures that all services defined in the `docker-compose.yml` file are up and running in the background.

```powershell
docker-compose up -d

2. Building Docker Containers
Next, the script initiates the build process for the Docker containers. The Start-Process cmdlet is used to run the docker-compose build command. The -Wait parameter ensures that the script waits for the build process to complete before proceeding. The -PassThru parameter captures the exit code of the build process, which is crucial for determining if the build was successful.

$process = Start-Process -FilePath "docker-compose" -ArgumentList "build" -Wait -PassThru

3. Checking Build Status
After the build process finishes, the script checks the exit code. If the exit code is 0, the build is considered successful, and a success message is displayed. Otherwise, an error message is displayed, indicating the build has failed along with the corresponding exit code.

Write-Host "Build process finished with exit code: $($process.ExitCode)"
if ($process.ExitCode -eq 0) {
    Write-Host "Build completed successfully."
} else {
    Write-Host "Build failed with exit code $($process.ExitCode)."
}

4. Retrieving Jenkins Initial Admin Password
The script then attempts to retrieve the initial admin password for Jenkins. A Start-Sleep cmdlet is used to pause the script for 10 seconds, giving Jenkins enough time to generate the password. After the pause, the script runs a docker exec command to access the Jenkins container and read the password from the initialAdminPassword file.

Write-Host "Attempting to retrieve initial admin password..."

Start-Sleep -Seconds 10

docker exec devops_arch_docker_01-jenkins-1 cat /var/jenkins_home/secrets/initialAdminPassword


This script automates key aspects of setting up and managing a Jenkins Docker environment, making it easier to deploy and configure Jenkins in a consistent and repeatable manner.

Dockerfile for SSH Server Setup

This Dockerfile creates a Docker container with an SSH server installed, allowing remote access to the container.

Step-by-Step Breakdown of the Dockerfile:
1. Base Image
The Dockerfile starts with the ubuntu:latest image as the base. You can replace this with any other base image that suits your needs.

FROM ubuntu:latest


2. Installing SSH Server
The apt-get command is used to update the package list and install the OpenSSH server. The apt-get clean command ensures that no unnecessary files are left behind, keeping the image size small.

RUN apt-get update && \
    apt-get install -y openssh-server && \
    apt-get clean


3. Setting Root Password
The chpasswd command sets the root password for the SSH server. For security reasons, it is highly recommended to change this password to something more secure before deploying the container.


RUN echo 'root:Admin@123' | chpasswd


4. Permitting Root Login via SSH
By default, root login via SSH might be disabled or restricted. This step modifies the SSH configuration file (/etc/ssh/sshd_config) to allow root login.

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

5. Enabling Password Authentication
This step ensures that password authentication is enabled in the SSH server configuration. This is necessary if you plan to log in using a username and password.

RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config


6. Exposing SSH Port
The Dockerfile exposes port 22, which is the default port for SSH. If you need to use a different port, you can modify this line.

EXPOSE 22


7. Ensuring SSH Directory Exists
The /var/run/sshd directory is created and given the correct permissions to ensure that the SSH server starts without issues.

RUN mkdir /var/run/sshd 
RUN chmod 0755 /var/run/sshd


8. Starting SSH Service
Finally, the SSH service is started in the container, running in the foreground with the -D option to keep the container alive.

CMD ["/usr/sbin/sshd", "-D"]


This Dockerfile sets up a basic SSH server within a Docker container, allowing you to connect to the container remotely via SSH.