init - Initial Dockerfile, adds vim and git
------------------------------------------

docker login --username=thanujtk

docker build -t thanujtk/debian .

docker push thanujtk/debian

htop - add htop for above intial build
---------------------------------------

docker push thanujtk/debian