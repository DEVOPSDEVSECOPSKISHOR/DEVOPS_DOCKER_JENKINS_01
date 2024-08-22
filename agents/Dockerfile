# Use a base image with SSH installed (you can choose a different base image if needed)
FROM ubuntu:latest

# Install SSH server
RUN apt-get update && \
    apt-get install -y openssh-server && \
    apt-get clean

# Set the root password for the SSH server (CHANGE THIS PASSWORD!)
RUN echo 'root:Admin@123' | chpasswd

# Permit root login via SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Enable password authentication
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# SSH port (optional, change if needed)
EXPOSE 22

# Ensure the SSH directory exists
RUN mkdir /var/run/sshd 
RUN chmod 0755 /var/run/sshd

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]
