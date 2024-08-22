docker-compose up --build -d


for Docker ssh agent

cd agents

docker build -t ssh_server_image .

docker run -d -p 2222:22 --name ssh_server_container ssh_server_image