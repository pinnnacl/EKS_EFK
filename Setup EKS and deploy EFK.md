
#### Terroform code to deploy the EKS cluster

In the terraform code i am using custom module to deploy the EKS cluster in the private subnet of the aws VPC and with the help of bastion host I will access the EKS cluster. 

![Screenshot from 2025-06-10 11-50-55](https://github.com/user-attachments/assets/f07229fc-cdcc-465e-9e7f-6a25ff0c0068)



After validating the code, I made use of "**terraform plan**" command for getting more insights on how the terraform code will effect the existing infrastructure.

Using "**terraofrm apply**" command I deployed the EKS inftrastructure on the aws cloud.

## Deploy Elasticsearch, fluentbit and kibana using Helm chart

###### Create Namespace for Logging

```shell
kubectl create namespace logging
```

Install Elasticsearch using below command 

```bash
helm repo add elastic https://helm.elastic.co

helm repo update elastic

helm install elasticsearch --set persistence.storageClass=gp2 elastic/elasticsearch --version 8.5.1 -n logging
```

Now retrieve the Elasticsearch Username and Password using below command

```bash
kubectl get secrets --namespace=logging elasticsearch-master-credentials -ojsonpath='{.data.username}' | base64 -d

kubectl get secrets --namespace=logging elasticsearch-master-credentials -ojsonpath='{.data.password}' | base64 -d
```

![Screenshot from 2025-06-10 23-22-55](https://github.com/user-attachments/assets/13ea66f9-d1da-4225-8a76-b232b765baa9)



Deploy Fluentbit using below Helm repository

```bash
helm repo add fluent https://fluent.github.io/helm-charts
helm install fluent-bit fluent/fluent-bit -f fluentbit-values.yaml -n logging
```

add the below configuration in the values.yml file

![[Screenshot from 2025-06-10 23-30-29.png]]

```bash
helm install fluent-bit -n logging .
```


![[Screenshot from 2025-06-10 23-34-49.png]]

Now deploy kibana

```bash
helm install kibana elastic/kibana -n logging
```

![[Screenshot from 2025-06-10 23-58-38.png]]

For demonstration purpose I am using port-forwarding to access the Kibana UI

![[Screenshot from 2025-06-10 21-56-59.png]]
