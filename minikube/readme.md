Installation on Windows 10 (Home network) on Hyper V (Default Switch)
----------------------------------------------------------------------
minikube.exe start --vm-driver="hyperv" --hyperv-virtual-switch="Default Switch" --cpus 8 --memory 16384

If default switch not available then create a switch and ensure to share
internet for that switch.

When docker kubernetes is installed then get token to login to dashboard after running

```
> kubectl proxy
> kubectl -n kube-system  describe secret default
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/overview?namespace=default
 ```

minikube commands
--------------------------

 ```
> minikube status
> minikube addons list
> minikube addons enable dashboard
> minikube dashboard
> minikube ip
> minikube stop/start
> minikube 

> kubectl proxy  (http://127.0.0.1:8001/ui)
> kubectl cluster-info
> kubectl run hello-nginx --image=nginx --port=80
> kubectl get pods  (check hello-nginx is running)
> kubectl exec -it hello-nginx-c56599c4d-jw9hk bash (get id from pods to login to container)
> kubectl expose deployment hello-nginx --port=80 --type=NodePort
> kubectl.exe get services  (shows the mapped port for access)
> kubectl get svc  (to get port)
> minikube service hello-nginx --url  (if --url is not given will open in browser)
> kubectl get pods -n kube-system

> kubectl delete services hello-nginx
> kubectl delete deployment hello-nginx

> kubectl scale --replicas=3 deployment/hello-nginx  (scale it)
> minikube update-context (in case ip got changed)
 ```
 
 Tomcat deployment without deployment.yml, check minikube\tomcat
  ```
  > kubectl run hello-tomcat --image=tomcat --port=8080
  > kubectl expose deployment hello-tomcat --port=8080 --type=NodePort
  > kubectl get pods
  > kubectl.exe get services
  > minikube service hello-tomcat
  > kubectl delete services hello-tomcat
  > kubectl delete deployment hello-tomcat
  ```
[K8S Cheat Sheet](https://design.jboss.org/redhatdeveloper/marketing/kubernetes_cheatsheet/cheatsheet/cheat_sheet/images/kubernetes_cheat_sheet_r1v1.pdf)

[Kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)

[Kubectl commands/reference](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands)

Examples
-------------------
1. minikube/First_k8s_tomcat/deployment.yml

      ```
      > kubectl api-versions (provides the kubectl api versions supported that can be used in deployment.yml, apiVersion: apps/v1)
      > kubectl apply -f ./deployment.yml
      > kubectl expose deployment tomcat-deployment --type=NodePort
      > kubectl get services
      > minikube service tomcat-deployment (--url)
      > kubectl delete services tomcat-deployment
      > kubectl delete deployment tomcat-deployment
      
    Either change the value in configuratin for replicas and redeploy or use below command to change replicas for deployment pods
      > kubectl scale --replicas=4 deployment/tomcat-deployment
   
     Now four instances are running this requires a load balancer and we could not use (kubectl expose deployment tomcat-deployment --type=NodePort) as it is one-to-one mapping
   
      > kubectl expose deployment tomcat-deployment --type=LoadBalancer --port=8080 --target-port=8080 --name tomcat-load-balancer
      > kubectl describe services tomcat-load-balancer
      > minikube service tomcat-load-balancer --url (to get load balancer url)
      > kubectl rollout status deployment tomcat-deployment (to know rollout status)
   
     Now if you look at the deployment.yml spec.containers image is tomcat:9.0 and sepc.container.name is tomcat, let us upgrade the deployment 
      > kubectl set image deployment/tomcat-deployment tomcat=tomcat:9.0.1
   
     To know the history of rollout
     > kubectl rollout history deployment/tomcat-deployment
     > kubectl rollout history deployment/tomcat-deployment --revision=2
   
     Labels and selectors
     You can label - deployments, services and nodes in k8s (example: label a node that it has SSD storage and then use
        selector to tell the deployment that our app should only ever go onto a node with SSD storage)
   
      First get the nodes 
      > kubectl get nodes
      > kubectl describe node minikube (minikube is the node name, role=master)
      > kubectl label node minikube storageTypeThanuj=ssd (it is just a key=value pair which will be stored in labels)
      ```
   
2. minikube/WithLabels

    ```
     Continuation, once label is created, modify deployment.yml to have nodeSelector and deploy
     > kubectl apply -f .\deployment.yml
     > kubectl expose deployment tomcat-deployment-jdk13 --type=LoadBalancer --port=8080 --target-port=8080 --name tomcat-load-balancer
     > kubectl get services
     > kubectl describe services tomcat-load-balancer
     > minikube service tomcat-load-balancer --url
    ```
 3. minikube/health - [Health checks (readiness or liveness probe)]
 
    ```
      Copy deployment.yml from minikube/WithLabels, changes related to health is done 
      
     > kubectl apply -f ./deployment.yml
     > kubectl describe pods tomcat-deployment-jdk13 (or to get all pods > kubectl describe pods)
     > kubectl describe deployment tomcat-deployment-jdk13
     
     To know the node stats
     > kubectl describe node minikube
     > kubectl get pods --all-namespaces
    ```
4.  DNS and Service Discovery (minikube/dns_and_service_discovery)

    ```
    First deployment is mysql with deployment name "wordpress-mysql", which resolves as host name
    > kubectl create -f mysql-deployment.yml

    Deploy wordpress
    > kubectl create -f wordpress-deployment.yml
    ```
 
5.  quotas (minikube/quotas)
    
    ```
    Create a custom namespace by name thanuj
    > kubectl create ns thanuj
    > kubectl get ns
    
    To know in the background how kubectl is using API (verbose enabled with -v=9), note for curl "https" on windows use double quote
    >  kubectl -v=9 get pods
    
    Getting existing pods from default namespace using curl
    > curl -XGET -H "Accept: application/json" localhost:8001/api/v1/namespaces/default/pods
    
    Creating a pod using json with curl command (check quotas/pod.json)
    > kubectl get pods (no pods shown, we will create one by image name ghost as defined in pod.json)
    
    From quotas folder 
    > curl -H "Content-Type: application/json" --data @./pod.json -XPOST http://localhost:8001/api/v1/namespaces/default/pods
    > kubectl get pods 
    
    To delete using curl
    > curl -XDELETE localhost:8001/api/v1/namespaces/default/pods/ghost
    
    Creating ghost application in thanuj namespace (for default > kubectl create -f pod.json)
    > curl -H "Content-Type: application/json" --data @pod.json -XPOST http://localhost:8001/api/v1/namespaces/thanuj/pods
    > kubectl get pods -n thanuj
    
    Create a quota with hard restriction to have only one pod, this will be created in default namespace
    > kubectl create quota tkquota --hard pods=1
    > kubectl get resourcequotas
    > kubectl get resourcequotas tkquota -o yaml
    
    Now deploy the qpod.json which is modified to name=tkquota and deploy to default namespace
    > curl -H "Content-Type: application/json" --data @qpod.json -XPOST http://localhost:8001/api/v1/namespaces/default/pods
    
    Re-run and you get quota exceeded
    > kubectl delete pod tkquota
    > kubectl -n thanuj delete pod ghost
    > kubectl -n thanuj delete pod tkquota
    > kubectl create -f pod.json
    
    Using labels (find labels which is metadata of pods)
    > kubectl get pods  --show-labels
    > kubectl -n kube-system get pods  --show-labels
    
    To create a label for ghost
    > kubectl label pods ghost foo=bar
    > kubectl get pods -l foo=bar (query by label)
    > kubectl get pods -Lfoo=bar (another way to query by label)
    ```
  
  6. Looking at API schema version group
  ```
  > kubectl api-versions
  ```