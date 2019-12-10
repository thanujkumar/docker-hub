Installation on Windows 10 (Home network) on Hyper V (Default Switch)
----------------------------------------------------------------------
minikube.exe start --vm-driver="hyperv" --hyperv-virtual-switch="Default Switch" --cpus 8 --memory 16384

If default switch not available then create a switch and ensure to share
internet for that switch.

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

> kubectl delete services hello-nginx
> kubectl delete deployment hello-nginx

> kubectl scale --replicas=3 deployment/hello-nginx  (scale it)
> minikube update-context (in case ip got changed)
 ```
[K8S Cheat Sheet](https://design.jboss.org/redhatdeveloper/marketing/kubernetes_cheatsheet/cheatsheet/cheat_sheet/images/kubernetes_cheat_sheet_r1v1.pdf)

