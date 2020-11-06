Notes:

Hypervisor technology (VMWare, VBox) - need guest operating system for each VM and resources either wasted or duplicated. No easy migration of VM

![Alt](./images/hypervisor.png "HYPERVISOR TECH - OLD")


Docker Technology - container based virtualization technology

![Alt](./images/containers.png "CONTAINER TECH - NEW")

Docker Info

Docker daemon is also referred as docker engine and docker server

![Alt](./images/docker.png "Docker Info")

Docker Public Registry is docker-hub (inside registry, images are stored in repositories.  
So Docker repository is collection of different docker images with the same name [example: thanujtk/jenkins:tags],  
that have different tags, each tag usually represent different version of the image - using image layers - **docker history**)

**Note** - __docker container run__ or __docker run__ is short hand for __docker container create__, so always new container is created, instead use __docker container start__  or __docker start__

```
docker history busybox (provides different image layers)
docker run --rm -it busybox sh (to remove the container when execution is done)
docker run -it busybox sh  (below is the container id created by this run)
docker start -i fef75487bdaf
```
![Alt](./images/docker-layers.png "Docker Image Layers")

![Alt](./images/docker-rw-layer.png "Docker Image RW Layer")

**Two ways to build docker images**
1. Commit changes made to docker container
2. Write a dockerfile

```
> docker run -it debian:jessie   (install base image and to it install git)
> root@8dffaa23f6f6:/# apt-get update && apt-get install -y git  (inside the container)
> docker commit 8dffaa23f6f6  thanujtk/debian:1.0 (docker ps to get image id of above container)
> docker history thanujtk/debian:1.0  (to know the new layer that has been added)
```
In case of dockerfile each instruction create a new image layer (instruction specifies what to do when building image)

The '.' for docker build is **"docker build context path"**
1. docker build command takes the path to build context as argument
2. when build starts docker build client would pack all the files in build context into a tarball then transfer file to the daemon
3. By default, docker would search for default Dockerfile in the build context path

```
 > docker login  ( https://registry-1.docker.io/v2/ )
 > docker build -t thanujtk/debian:1.1 -f 01-Dockerfile .
 > docker history thanujtk/debian:1.1 (to know the images layer for each RUN command)
 
 Reduce the image layers created
 > docker build -t thanujtk/debian:1.2 -f 02-Dockerfile .
 > docker history thanujtk/debian:1.2 (less image layers and also less memory)
 
```
##### <u>CMD Instruction</u>
1. CMD instruction specifies what command needs to be run when the container starts up.
2. If we don't specify CMD instruction in the Dockerfile, docker will use the default command defined in the base image.
3. The CMD instruction doesn't run when building image, it only runs when the container starts up.
4. You can specify the command in either exec form which is preferred or in shell form
5. We can override the CMD instruction at container startup

```
> docker build -t thanujtk/debian:1.3 -f 03-Dockerfile .
> docker run --rm thanujtk/debian:1.3  (This will print hello world text)
> docker run --rm thanujtk/debian:1.3 ls -la  (overriding default cmd)
```

##### <u>Docker Cache</u>
1. Each time docker build (image creation) executes a instruction, it builds new image layer
2. Next time, if the same instruction is run (no change), docker will simply reuse the existing layer

Sometime cache may create problems due to aggressive caching to avoid cache altogether specify **--no-cache** option
```
> docker build -t thanujtk/debian:1.3 -f 03-Dockerfile . --no-cache=true
```

##### <u>COPY Instruction</u>
1. COPY instruction copies new files or directories from build context and adds them to the container file system.
```
> docker build -t thanujtk/debian:1.4 -f 04-Dockerfile . 
> docker run --rm thanujtk/debian:1.4  ls -la ./tmp/
> docker run --rm -it thanujtk/debian:1.4  (login to container with default CMD and check /tmp)
```
##### <u>ADD Instruction</u>
1.  Similar to COPY, in addition allows to download file from internet and copy to container.
2. ADD instruction also has ability to automatically unpack compressed files.


##### <u>Tagging existing image with new name</u>

```
> docker tag b59d8cfe1024 thanujtk/tutorial_debian:1.1  (changing thanujtk/debian:1.4 to new tag, note image id will be same)
> docker login --usename=thanujtk
> docker push thanujtk/tutorial_debian:1.1
```

##### <u>Running docker app as admin user - 05-Dockerfile</u>
```
> docker build -t thanujtk/debian:1.5 -f 05-Dockerfile .
> docker run -it  --rm thanujtk/debian:1.5 ( will be placed at > admin@57ca20d81d77:/images$ )
> docker exec -it <container-id> bash ( you can login to running container from new command prompt to know that default user is admin)
```

##### <u> Docker Compose </u>
Compose is a tool for defining and running multi-container Docker applications.
