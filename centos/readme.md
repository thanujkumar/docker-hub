
image-building - add java, maven, docker, jenkins for below build (1.2, latest)
--------------------------------------------
Added using modifying container and saving as image 

docker commit container_ID repository_name:tag 

docker push thanujtk/centos:1.2 (also as latest)

htop - add htop for above below build (1.1)
------------------------------------------

docker build -t thanujtk/centos:latest .

docker push thanujtk/centos:latest

##check layer >docker history thanujtk/debian:latest

init - Initial Dockerfile, adds vim and git (1.0)
------------------------------------------

docker login --username=thanujtk

docker build -t thanujtk/centos:1.0 .

docker push thanujtk/centos