# k8s terraform test
this is a simple example for k8s and terraform test. It run in your local PC.

## Prerequisite
1. install docker destop
2. install [k8s](https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/)
3. install [terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
4. install [minikube](https://minikube.sigs.k8s.io/docs/start/)

5. build docker image.
    
    in server fohlder run
        
    ```
    eval $(minikube docker-env)
    ```
    
    ```
    docker build -f Dockerfile -t tcp-server .
    ```
    
    in client fohlder run
    
    ```
    eval $(minikube docker-env)
    ```
    
    ```
    docker build -f Dockerfile -t tcp-client .
    ```
6. run minikube 
    ```
    minikube start --cni=cilium --memory=4096
    ```
## Use Terraform

Copy the config file to the local folder, you can find the file inside lens (right click the cluster icon, setting ). Modify the `main.tf`. In side the root folder, run 

```
terraform init
```

```
terraform plan
```

```
terraform apply -auto-approve
```

## Use Cilium for NetworkPolicy

Please follow the [guide](https://kubernetes.io/docs/tasks/administer-cluster/network-policy-provider/cilium-network-policy/)
