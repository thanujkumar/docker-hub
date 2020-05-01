Development inside the container to build plugin 

Fetch the below container
 
```
docker run -it --entrypoint sh -v C:\DOCKER\m4:/src -p 8081:8080 maven:3.6.3-jdk-8

Also i mapped my maven repo to container repo (/root/.m2/repository) as below

docker run -it --entrypoint sh -v C:\DOCKER\m4:/src -v C:\MAVEN_REPO:/root/.m2/repository -p 8081:8080 maven:3.6.3-jdk-8

Now check java and maven are installed and src is mapped to local folder
> cd /src
> mvn -U archetype:generate -Dfilter="io.jenkins.archetypes:"

 select: hello-world-plugin (4)
 version: 1.6
 artifactid: m4-demo

 Next run below command to make a build (target)
 > mvn verify

 From current folder (shows target) run below command which will run development jenkins server
> mvn hpi:run

Should be able to connection jenkins (8081) and find the plugin hello-world (TODO-plugin)
and use it in feestyle project to print hello world (Build section -> Say Hello)
```