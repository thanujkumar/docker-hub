1. Build the Dockerfile from the location where Dockerfile exists

    ```
    > docker build -t thanujtk/jenkins-master-kube:v1.0 .
    > docker images (should show thanujtk/jenkins-master-kube:v1.0)
    > docker push thanujtk/jenkins-master-kube:v1.0
   
    To check image is valid, you can run as docker container
    > docker run --rm -d -p 8080:8080 thanujtk/jenkins-master-kube:v1.0
    > docker delete <docker id>
    ```
   
2. Next is create jenkins-deployment.yaml for running the image as pod in kubernetes
    ```
    Create a namespace ci-cd
    > kubectl create ns ci-cd
    To create deployment in ci-cd
    > kubectl apply -f jenkins-deployment.yaml -n ci-cd
    ```
