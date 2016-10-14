#### Clone this first and then

    docker-compose up

    firefox http://localhost:8080

#### Docker total cleanup

    docker rm -f $(docker ps -aq)
    docker rmi -f $(docker images -aq)
    docker volume rm $(docker volume ls -q)
    docker ps -a
    docker images
    docker volume ls
