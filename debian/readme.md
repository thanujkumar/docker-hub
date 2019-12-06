

htop - add htop for above intial build (latest)
------------------------------------------

docker build -t thanujtk/debian:latest .

docker push thanujtk/debian:latest

##check layer >docker history thanujtk/debian:latest

init - Initial Dockerfile, adds vim and git (1.0)
------------------------------------------

docker login --username=thanujtk

docker build -t thanujtk/debian:1.0 .

docker push thanujtk/debian