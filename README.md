# k8s terraform test
this is a simple example for k8s and terraform test. It run in your local PC.

## Prerequisite
1. install docker destop
2. install [k8s](https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/)
3. install [terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
4. enable k8s in local docker.[link](https://kubernetes.io/blog/2019/07/23/get-started-with-kubernetes-using-python/#:~:text=Kubernetes%20in%20Docker-,Desktop,-Once%20you%20have)
5. config k8s
    
    ```
        kubectl config use-context docker-for-desktop
    ```
6. build docker image.
    
    in server fohlder run
    
    ```
    docker build -f Dockerfile -t tcp-server .
    ```
    
    in client fohlder run
    
    ```
    docker build -f Dockerfile -t tcp-client .
    ```

## Use Terraform

Copy the config file here, you can find the file inside lens (right click the cluster icon, setting ). Modify the `main.tf`. In side the root folder, run 

```
terraform init
```

```
terraform plan
```

```
terraform apply -auto-approve
```
