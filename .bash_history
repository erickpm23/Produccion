az account set --subscription 0ffeefdc-476a-483a-9096-05fdbfa2304a
az aks get-credentials --resource-group microserviciosRG --name microservices-cluster
# Mostrar todas las implementaciones de todos los espacios de nombres
kubectl get deployments --all-namespaces=true
kubectl get all
kubectl get namespace
REGISTRY_NAME=contenedoresorocash.azurecr.io
SOURCE_REGISTRY=k8s.gcr.io
CONTROLLER_IMAGE=ingress-nginx/controller
CONTROLLER_TAG=v1.0.4
PATCH_IMAGE=ingress-nginx/kube-webhook-certgen
PATCH_TAG=v1.1.1
DEFAULTBACKEND_IMAGE=defaultbackend-amd64
DEFAULTBACKEND_TAG=1.5
CERT_MANAGER_REGISTRY=quay.io
CERT_MANAGER_TAG=v1.5.4
CERT_MANAGER_IMAGE_CONTROLLER=jetstack/cert-manager-controller
CERT_MANAGER_IMAGE_WEBHOOK=jetstack/cert-manager-webhook
CERT_MANAGER_IMAGE_CAINJECTOR=jetstack/cert-manager-cainjector
az acr import --name $REGISTRY_NAME --source $SOURCE_REGISTRY/$CONTROLLER_IMAGE:$CONTROLLER_TAG --image $CONTROLLER_IMAGE:$CONTROLLER_TAG
az acr import --name $REGISTRY_NAME --source $SOURCE_REGISTRY/$PATCH_IMAGE:$PATCH_TAG --image $PATCH_IMAGE:$PATCH_TAG
az acr import --name $REGISTRY_NAME --source $SOURCE_REGISTRY/$DEFAULTBACKEND_IMAGE:$DEFAULTBACKEND_TAG --image $DEFAULTBACKEND_IMAGE:$DEFAULTBACKEND_TAG
az acr import --name $REGISTRY_NAME --source $CERT_MANAGER_REGISTRY/$CERT_MANAGER_IMAGE_CONTROLLER:$CERT_MANAGER_TAG --image $CERT_MANAGER_IMAGE_CONTROLLER:$CERT_MANAGER_TAG
az acr import --name $REGISTRY_NAME --source $CERT_MANAGER_REGISTRY/$CERT_MANAGER_IMAGE_WEBHOOK:$CERT_MANAGER_TAG --image $CERT_MANAGER_IMAGE_WEBHOOK:$CERT_MANAGER_TAG
az acr import --name $REGISTRY_NAME --source $CERT_MANAGER_REGISTRY/$CERT_MANAGER_IMAGE_CAINJECTOR:$CERT_MANAGER_TAG --image $CERT_MANAGER_IMAGE_CAINJECTOR:$CERT_MANAGER_TAG
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
ACR_URL=contenedoresorocash.azurecr.io
helm install nginx-ingress ingress-nginx/ingress-nginx     --version 4.0.13     --namespace ingress-yarviz-prod --create-namespace     --set controller.replicaCount=2     --set controller.nodeSelector."kubernetes\.io/os"=linux     --set controller.image.registry=$ACR_URL     --set controller.image.image=$CONTROLLER_IMAGE     --set controller.image.tag=$CONTROLLER_TAG     --set controller.image.digest=""     --set controller.admissionWebhooks.patch.nodeSelector."kubernetes\.io/os"=linux     --set controller.admissionWebhooks.patch.image.registry=$ACR_URL     --set controller.admissionWebhooks.patch.image.image=$PATCH_IMAGE     --set controller.admissionWebhooks.patch.image.tag=$PATCH_TAG     --set controller.admissionWebhooks.patch.image.digest=""     --set defaultBackend.nodeSelector."kubernetes\.io/os"=linux     --set defaultBackend.image.registry=$ACR_URL     --set defaultBackend.image.image=$DEFAULTBACKEND_IMAGE     --set defaultBackend.image.tag=$DEFAULTBACKEND_TAG     --set defaultBackend.image.digest=""
kubectl --namespace ingress-yarviz-prod get services -o wide -w nginx-ingress-ingress-nginx-controller
az network dns record-set a add-record     --resource-group microservicioRG     --zone-name orocash.ec     --record-set-name "*" \
kubectl --namespace ingress-yarviz-prod get services -o wide -w nginx-ingress-ingress-nginx-controller
az network dns record-set a add-record     --resource-group microservicioRG     --zone-name orocash.ec     --record-set-name "*" \
az network dns record-set a add-record     --resource-group microserviciosRG     --zone-name orocash.ec     --record-set-name "*"     --ipv4-address 104.45.179.115
IP=104.45.179.115
DNSNAME=yarviz-prod
PUBLICIPID=$(az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$IP')].[id]" --output tsv)
az network public-ip update --ids $PUBLICIPID --dns-name $DNSNAME
az network public-ip show --ids $PUBLICIPID --query "[dnsSettings.fqdn]" --output tsv
kubectl label namespace ingress-yarviz-prod cert-manager.io/disable-validation=true
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager   --namespace ingress-yarviz-prod   --version $CERT_MANAGER_TAG   --set installCRDs=true   --set nodeSelector."kubernetes\.io/os"=linux   --set image.repository=$ACR_URL/$CERT_MANAGER_IMAGE_CONTROLLER   --set image.tag=$CERT_MANAGER_TAG   --set webhook.image.repository=$ACR_URL/$CERT_MANAGER_IMAGE_WEBHOOK   --set webhook.image.tag=$CERT_MANAGER_TAG   --set cainjector.image.repository=$ACR_URL/$CERT_MANAGER_IMAGE_CAINJECTOR   --set cainjector.image.tag=$CERT_MANAGER_TAG
touch cluster-issuer.yaml
mkdir Yarviz-Prod
mv cluster-issuer.yaml Yarviz-Prod/
cd Yarviz-Prod/
kubectl apply -f cluster-issuer.yaml 
touch deployment-sqlserver-yarviz-prod.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
spec:
touch yarviz-prod-mssql-pvc.yaml
touch yarviz-prod-secret-sql.yaml
touch deployment-sqlserver-yarviz.yaml
rm deployment-sqlserver-yarviz-prod.yaml 
touch pvc-yarviz-mssql.yaml
rm yarviz-prod-mssql-pvc.yaml 
touch secret-sql-yarviz.yaml
rm yarviz-prod-secret-sql.yaml 
touch service-sqlserver-yarviz.yaml
touch pvc-sqlserver-yarviz.yaml
rm pvc-yarviz-mssql.yaml 
kubectl get all -n ingress-yarviz-prod
kubectl apply -f secret-sql-yarviz.yaml 
kubectl apply -f pvc-sqlserver-yarviz.yaml 
kubectl apply -f deployment-sqlserver-yarviz.yaml 
kubectl apply -f service-sqlserver-yarviz.yaml 
kubectl get all -n ingress-yarviz-prod
touch ingress-yarviz.yaml
az network public-ip show --ids $PUBLICIPID --query "[dnsSettings.fqdn]" --output tsv
kubectl apply -f ingress-yarviz.yaml 
kubectl get ingress -n ingress-yarviz-prod
kubectl get certificate --namespace ingress-yarviz-prod
kubectl get ingress -n ingress-yarviz-prod
kubectl apply -f ingress-yarviz.yaml 
kubectl apply -f service-sqlserver-yarviz.yaml 
kubectl apply -f ingress-yarviz.yaml 
kubectl get certificate --namespace ingress-yarviz-prod
kubectl delete -f ingress-yarviz.yaml 
kubectl apply -f ingress-yarviz.yaml 
kubectl get certificate --namespace ingress-basic
kubectl get certificate --namespace ingress-yarviz-prod
kubectl get ingress -n ingress-yarviz-prod
kubectl get all -n ingress-yarviz-prod
kubectl apply -f service-sqlserver-yarviz.yaml 
kubectl apply -f ingress-yarviz.yaml 
kubectl get all -n ingress-yarviz-prod
kubectl get pods -n ingress-yarviz-prod
kubectl exec -it yarviz-mssql-deployment-8c6cb765b-wtm4n /bin/bash
kubectl exec -it yarviz-mssql-deployment-8c6cb765b-wtm4n /bin/bash -n ingress-yarviz-prod
kubectl get ingress -n ingress-yarviz-prod
wget http://bashupload.com/rd_d9/H5L9D.zip
ls
rm -r H5L9D.zip 
kubectl exec -it yarviz-mssql-deployment-8c6cb765b-wtm4n /bin/bash -n ingress-yarviz-prod
kubectl apply -f service-sqlserver-yarviz.yaml 
kubectl get svc -n ingress-yarviz-prod
kubectl exec -it yarviz-mssql-deployment-8c6cb765b-wtm4n /bin/bash -n ingress-yarviz-prod
kubectl apply -f service-sqlserver-yarviz.yaml 
kubectl aplpy -f ingress-yarviz.yaml 
kubectl apply -f ingress-yarviz.yaml 
kubectl apply -f service-sqlserver-yarviz.yaml 
kubectl apply -f ingress-yarviz.yaml 
kubectl delete -f ingress-yarviz.yaml 
kubectl get certificate --namespace ingress-yarviz-pod
kubectl get certificate
kubectl get ingress
kubectl apply -f ingress-yarviz.yaml 
kubectl get certificate --namespace ingress-yarviz-pod
kubectl get ingress -n ingress-yarviz-prod
kubectl get certificate --namespace ingress-yarviz-prod
kubectl exec -it yarviz-mssql-deployment-8c6cb765b-wtm4n /bin/bash -n ingress-yarviz-prod
kubectl get all -n ingress-yarviz-prod
kubectl apply -f service-sqlserver-yarviz.yaml 
kubectl get svc -n ingress-basic
kubectl get svc -n ingress-yarviz-prod
cd Yarviz-Prod/
kubectl apply -f pvc-sqlserver-yarviz.yaml 
kubectl delete -f pvc-sqlserver-yarviz.yaml 
kubectl patch pvc persistentvolumeclaim -p '{"metadata":{"finalizers":null}}'
kubectl patch pvc persistentvolumeclaim -p '{"metadata":{"finalizers":null}}' -n ingress-yarviz-pod
kubectl patch pvc persistentvolumeclaim -p '{"metadata":{"finalizers":null}}' -n ingress-yarviz-prod
kubectl get pvc -n ingress-yarviz-prod
kubectl patch pvc mssql-data -p '{"metadata":{"finalizers":null}}' -n ingress-yarviz-prod
kubectl get pvc -n ingress-yarviz-prod
kubectl get pvc,pv,storage -n ingress-yarviz-prod
kubectl get pvc,pv -n ingress-yarviz-prod
kubectl patch pvc mssql-data -p '{"metadata":{"finalizers":null}}' -n ingress-yarviz-prod
kubectl get namespace 
kubectl exec -it yarviz-mssql-deployment-8c6cb765b-wtm4n /bin/bash -n ingress-yarviz-prod
kubectl delete namespace ingress-yarviz-prod
kubectl get namespace
kubectl get namespace ingress-yarviz-prod -o json > tmp.json
curl -k -H "Content-Type: application/json" -X PUT --data-binary @tmp.json https://localhost:8001/api/v1/namespaces/ingress-yarviz-prod/finalize
cd Yarviz-Prod/
curl -k -H "Content-Type: application/json" -X PUT --data-binary @tmp.json https://localhost:8001/api/v1/namespaces/ingress-yarviz-prod/finalize
cd Yarviz-Prod/
kubectl get namespace
kubectl proxy
kubectl get namespace
kubectl apply -f pvc-sqlserver-yarviz.yaml 
kubectl delete -f pvc-sqlserver-yarviz.yaml 
kubectl create namespace ingress-yarviz-prod
kubectl get namespace
kubectl apply -f pvc-sqlserver-yarviz.yaml 
kubectl apply -f secret-sql-yarviz.yaml 
kubectl apply -f deployment-sqlserver-yarviz.yaml 
kubectl apply -f service-sqlserver-yarviz.yaml 
rm tmp.json 
ls
mv cluster-issuer.yaml /home/servicios/
cd ..
ls
cd Yarviz-Prod/
mv ingress-yarviz.yaml /home/servicios/
ls
kubectl get all -n ingress-yarviz-prod
kubectl exec -it yarviz-mssql-deployment-8c6cb765b-29vzv /bin/bash
kubectl exec -it yarviz-mssql-deployment-8c6cb765b-29vzv /bin/bash -n ingress-yarviz-prod
kubectl get svc -n ingress-yarviz-prod
kubectl exec -it yarviz-mssql-deployment-8c6cb765b-29vzv /bin/bash -n ingress-yarviz-prod
kubectl get svc -n ingress-yarviz-prod
ls
mkdir RDS-Prod
cd RDS-Prod/
touch deployment-api-validacion.yaml
touch service-api-validacion.yaml
kubectl get namespace
kubectl create namespace ingress-rds
touch deployment-mysql-api-validacion.yaml
touch service-mysql-api-validacion.yaml
touch deployment-bi.yaml
touch service-bi.yaml
touch secret-mysql-api-validacion.yaml
kubectl apply -f deployment-mysql-api-validacion.yaml 
kubectl apply -f service-mysql-api-validacion.yaml 
kubectl apply -f secret-mysql-api-validacion.yaml 
kubectl get all -n ingress-rd
kubectl get all -n ingress-rds
kubectl apply -f deployment-api-validacion.yaml 
kubectl apply -f service-api-validacion.yaml 
kubectl get all -n ingress-rds
kubectl apply -f service-api-validacion.yaml 
kubectl get pods -n ingress-rds
kubectl exec -it api-validacion-mysqlserver-deployment-6b7bc46f5-gvv48 /bin/bash
kubectl exec -it api-validacion-mysqlserver-deployment-6b7bc46f5-gvv48 /bin/bash -n ingress-rds
kubectl get pods -n ingress-rds
kubectl exec -it api-validacion-deployment-7fdd8c4cd7-7bjl7 /bin/sh -n ingress-rds
kubectl get all -n ingress-rds
kubectl exec -it api-validacion-mysqlserver-deployment-6b7bc46f5-gvv48 /bin/bash -n ingress-rds
kubectl exec -it api-validacion-deployment-7fdd8c4cd7-7bjl7 /bin/sh -n ingress-rds
kubectl exec -it api-validacion-mysqlserver-deployment-6b7bc46f5-gvv48 /bin/bash -n ingress-rds
touch deployment-sqlserver-bi.yaml
touch service-sqlserver-bi.yaml
kubectl get all -n ingress-basic
kubectl get all -n ingress-rds
touch secret-sqlserver-bi.yaml
kubectl apply -f deployment-bi.yaml 
kubectl apply -f service-bi.yaml 
kubectl apply -f deployment-sqlserver-bi.yaml 
kubectl apply -f service-sqlserver-bi.yaml 
kubectl apply -f secret-sqlserver-bi.yaml 
kubectl get all -n ingress-rds
kubectl get secret -n ingress-rds
kubectl delete -f secret-sqlserver-bi.yaml 
kubectl apply -f secret-sqlserver-bi.yaml 
kubectl get all -n ingress-rds
kubectl exec -it bi-deployment-cfc68cfd5-rz7w6 /bin/bash
kubectl exec -it bi-deployment-cfc68cfd5-rz7w6 /bin/bash -n ingress-rds
kubectl get pods
kubectl get pods -n ingress-rds
kubectl exec -it bi-sql-deployment-669f599ccf-b5zn6 /bin/bash
kubectl exec -it bi-sql-deployment-669f599ccf-b5zn6 /bin/bash -n ingress-rds
kubectl get pods -n ingress-rds
kubectl exec -it bi-sql-deployment-669f599ccf-b5zn6 /bin/bash
kubectl exec -it bi-deployment-cfc68cfd5-rz7w6 /bin/bash -n ingress-rds
kubectl get svc -n ingress-rds
cd RDS-Prod/
kubectl apply -f service-mysql-api-validacion.yaml 
kubectl get all -n ingress-basic
kubectl get all -n ingress-rds
kubectl get pods ingress-nrds
kubectl get pods ingress-rds
kubectl get pods -n ingress-rds
kubectl get svc -n ingress-rds
kubectl exec -it bi-deployment-cfc68cfd5-rz7w6 /bin/bash
kubectl exec -it bi-deployment-cfc68cfd5-rz7w6 /bin/bash -n ingress-rds
kubectl get svc -n ingress-rds
kubectl get pods -n ingress-rds
kubectl exec -it bi-deployment-cfc68cfd5-rz7w6 /bin/bash
kubectl exec -it bi-deployment-cfc68cfd5-rz7w6 /bin/bash -n ingress-rds
touch deployment-frontend-bi.yaml
touch service-frontend-bi.yaml
kubectl apply -f deployment-frontend-bi.yaml 
kubectl apply -f service-frontend-bi.yaml
kubectl get all -n ingress-rds
kubectl apply -f service-sqlserver-bi.yaml 
kubectl get all -n ingress-rds
kubectl get all -n ingress-yarviz-prod
kubectl get secret -n ingress-yarviz-prod
kubectl get secret -n ingress-rds
kubectl get pods -n ingress-rds
kubectl exec -it frontend-bi-deployment-6d85f8c795-lsn4m
kubectl exec -it frontend-bi-deployment-6d85f8c795-lsn4m /bin/bash -n ingress-rds
kubectl get pods -n ingress-rds
kubectl exec -it api-validacion-mysqlserver-deployment-6b7bc46f5-gvv48 /bin/bash -n ingress-rds
kubectl exec -it bi-deployment-cfc68cfd5-rz7w6 /bin/bash -n ingress-rds
kubectl exec -it bi-sql-deployment-669f599ccf-b5zn6 /bin/bash -n ingress-rds
kubectl get pods -n ingress-yarviz-prod
kubectl exec -it yarviz-mssql-deployment-8c6cb765b-29vzv /bin/bash -n ingress-yarviz-prod
kubectl get svc -n ingress-rds
kubetcl get pods -n ingress-rds
kubectl get pods -n ingress-rds
kubectl exec -it api-validacion-deployment-7fdd8c4cd7-7bjl7 /bin/sh
kubectl exec -it api-validacion-deployment-7fdd8c4cd7-7bjl7 /bin/sh -n ingress-rds
az network public-ip show --ids $PUBLICIPID --query "[dnsSettings.fqdn]" --output tsv
IP=104.45.179.115
PUBLICIPID=$(az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$IP')].[id]" --output tsv)
az network public-ip show --ids $PUBLICIPID --query "[dnsSettings.fqdn]" --output tsv
kubectl get pods -n ingress-rds
kubectl exec -it api-validacion-deployment-7fdd8c4cd7-7bjl7 /bin/sh -n ingress-rds
kubectl get pods -n ingress-rds
kubectl exec -it api-validacion-deployment-7fdd8c4cd7-7bjl7 /bin/bash -n ingress-rds
kubectl exec -it api-validacion-deployment-7fdd8c4cd7-7bjl7 /bin/sh -n ingress-rds
kubectl exec -it pod/api-validacion-deployment-7fdd8c4cd7-7bjl7 /bin/sh -n ingress-rds
cd RDS-Prod/
ls
kubectl delete -f deployment-api-validacion.yaml 
kubectl apply -f deployment-api-validacion.yaml 
kubectl get pods -n ingress-rds
kubectl exec -it api-validacion-deployment-7fdd8c4cd7-6r2wd /bin/sh -n ingress-rds
kubectl exec -it api-validacion-mysqlserver-deployment-6b7bc46f5-gvv48 /bin/bash
kubectl exec -it api-validacion-mysqlserver-deployment-6b7bc46f5-gvv48 /bin/bash -n ingress-rds
kubectl exec -it api-validacion-mysqlserver-deployment-6b7bc46f5-gvv48 /bin/bash
kubectl exec -it api-validacion-deployment-7fdd8c4cd7-6r2wd /bin/sh -n ingress-rds
kubectl get all -n ingress-yarviz-prod
kubectl get pods -n ingress-rds
kubectl restart api-validacion-deployment-7fdd8c4cd7-6r2wd
kubectl exec -it api-validacion-deployment-7fdd8c4cd7-6r2wd /bin/sh -n ingress-rds
kubectl get all -n ingress-yarviz-prod
kubectl get pods -n ingress-rds
kubectl exec -it api-validacion-deployment-7fdd8c4cd7-6r2wd /bin/sh -n ingress-rds
cd ..
ls
kubectl get pods -n ingress-rds
kubectl exec -it api-validacion-mysqlserver-deployment-6b7bc46f5-gvv48 /bin/bash
kubectl exec -it api-validacion-mysqlserver-deployment-6b7bc46f5-gvv48 /bin/bash -n ingress-rds
kubectl exec -it api-validacion-deployment-7fdd8c4cd7-6r2wd /bin/sh -n ingress-rds
kubectl get all -n ingress-rds
kubectl exec -it bi-sql-deployment-669f599ccf-b5zn6 /bin/bash
kubectl exec -it bi-sql-deployment-669f599ccf-b5zn6 /bin/bash -n ingress-rds
kubectl get all -n ingress-yarviz-prod
kubectl delete pod/yarviz-mssql-deployment-8c6cb765b-29vzv
kubectl delete pod/yarviz-mssql-deployment-8c6cb765b-29vzv -n ingress-yarviz-prod
kubectl delete pod/yarviz-mssql-deployment-8c6cb765b-5rdgv -n ingress-yarviz-prod
kubectl get all -n ingress-yarviz-prod
kubectl log pod/yarviz-mssql-deployment-8c6cb765b-x6z65 -n ingress-yarviz-prod
kubectl logs pod/yarviz-mssql-deployment-8c6cb765b-x6z65 -n ingress-yarviz-prod
kubectl get all -n ingress-yarviz-prod
kubectl logs pod/yarviz-mssql-deployment-8c6cb765b-x4brj -n ingress-yarviz-prod
kubectl delete pod/yarviz-mssql-deployment-8c6cb765b-7kdm5 -n ingress-yarviz-prod
kubectl delete pod/yarviz-mssql-deployment-8c6cb765b-88jcv -n ingress-yarviz-prod
kubectl delete pod/yarviz-mssql-deployment-8c6cb765b-95fhd  -n ingress-yarviz-prod
kubectl delete pod/yarviz-mssql-deployment-8c6cb765b-9pt6k  -n ingress-yarviz-prod
kubectl get all -n ingress-yarviz-prod
kubectl delete deployment.apps/yarviz-mssql-deployment -n ingress-yarviz-prod
kubectl get all -n ingress-yarviz-prod
cd RDS-Prod/
kubectl apply -f deployment-sqlserver-bi.yaml 
kubectl get all -n ingress-yarviz-prod
cd ..
cd Yarviz-Prod/
kubectl apply -f deployment-sqlserver-yarviz.yaml 
kubectl get all -n ingress-yarviz-prod
kubectl logs pod/yarviz-mssql-deployment-8c6cb765b-rmtgk -n ingress-yarviz-prod
kubectl get all -n ingress-yarviz-prod
kubectl exec -it yarviz-mssql-deployment-8c6cb765b-rmtgk /bin/bash -n ingress-yarviz-prod
cd ..
kubectl get all -n ingress-rds
cd Rd
cd RDS-Prod/
kubectl delete -f deployment-bi.yaml 
kubectl apply -f deployment-bi.yaml 
kubectl get all -n ingress-rds
kubectl delete pod/bi-sql-deployment-669f599ccf-2d6tw -n ingress-rds
kubectl get all -n ingress-rds
kubectl delete pod/bi-sql-deployment-669f599ccf-4jwnw -n ingress-rds
kubectl delete pod/bi-sql-deployment-669f599ccf-b5zn6 -n ingress-rds
kubectl delete pod/bi-sql-deployment-669f599ccf-m9jbr -n ingress-rds
kubectl delete pod/bi-sql-deployment-669f599ccf-nbmgk -n ingress-rds
kubectl delete pod/bi-sql-deployment-669f599ccf-pq65g -n ingress-rds
kubectl get all -n ingress-rds
kubectl delete pod/bi-sql-deployment-669f599ccf-nlklz -n ingress-rds
kubectl delete pod/bi-sql-deployment-669f599ccf-r52s5 -n ingress-rds
kubectl delete pod/bi-sql-deployment-669f599ccf-v6tg7 -n ingress-rds
kubectl delete pod/bi-sql-deployment-669f599ccf-wdbsl -n ingress-rds
kubectl delete pod/bi-sql-deployment-669f599ccf-zvdgj -n ingress-rds
kubectl delete pod/bi-sql-deployment-669f599ccf-nlklz -n ingress-rds
kubectl get ald -n ingress-rds
kubectl get all -n ingress-rds
kubectl delete pod/bi-sql-deployment-669f599ccf-4jwnw -n ingress-rds
kubectl delete pod/bi-sql-deployment-669f599ccf-zvkh5 -n ingress-rds
kubectl get all -n ingress-rds
kubectl get all -n ingress-yarviz-prod
cd ..
cd Yarviz-Prod/
kubectl delete -f deployment-sqlserver-yarviz.yaml 
kubectl get all -n ingress-yarviz-prod
kubectl apply -f deployment-sqlserver-yarviz.yaml 
kubectl get all -n ingress-rds
kubectl get all -n ingress-yarviz-prod
kubectl delete -f deployment-sqlserver-yarviz.yaml 
kubectl apply -f deployment-sqlserver-yarviz.yaml 
kubectl get all -n ingress-yarviz-prod
top
kubectl get all -n ingress-yarviz-prod
kubectl logs pod/yarviz-mssql-deployment-8c6cb765b-ntzz7 -n ingress-yarviz-prod
kubectl delete -f deployment-sqlserver-yarviz.yaml 
kubectl get all -n ingress-yarviz-prod
kubectl get all -n ingress-rds
kubectl exec -it pod/bi-deployment-cfc68cfd5-7l5qz -n  ingress-rds
kubectl get all -n ingress-rds
kubectl exec -it bi-deployment-cfc68cfd5-7l5qz /bin/bash -n ingress-rds
kubectl get all -n ingress-rds
kubectl exec -it bi-sql-deployment-669f599ccf-vwcqf /bin/bash -n ingress-rds
kubectl get all -n ingress-yarviz-prod
kubectl apply -f deployment-sqlserver-yarviz.yaml 
kubectl get all -n ingress-yarviz-prod
kubectl delete -f deployment-sqlserver-yarviz.yaml 
kubectl apply -f deployment-sqlserver-yarviz.yaml 
kubectl get all -n ingress-yarviz-prod
kubectl exec yarviz-mssql-deployment-59549f9bcc-r578q /bin/bash -n ingress-yarviz-prod
kubectl exec -it yarviz-mssql-deployment-59549f9bcc-r578q /bin/bash -n ingress-yarviz-prod
kubectl get all -n ingress-yarviz-prod
cd ..
cd RDS-Prod/
touch pvc-sqlserver-bi.yaml
kubectl apply -f pvc-sqlserver-bi.yaml 
kubectl apply -f deployment-sqlserver-bi.yaml 
kubectl get all -n ingress-rds
kubectl delete replicaset.apps/bi-sql-deployment-669f599ccf -n ingress-rds
kubectl get all -n ingress-rds
kubectl exec -it bi-deployment-cfc68cfd5-7l5qz /bin/bash -n ingress-rds
kubectl get all -n ingress-rds
kubectl exec -it pod/bi-sql-deployment-5c6bd5486d-7qhlz /bin/bash -n ingress-rds
kubectl exec -it yarviz-mssql-deployment-59549f9bcc-r578q /bin/bash -n ingress-yarviz-prod 
kubectl get all -n ingress-rds
kubectl get all -n ingress-yarviz-prod
kubectl logs pod/yarviz-mssql-deployment-59549f9bcc-r578q -n ingress-yarviz-prod
kubectl log pod/yarviz-mssql-deployment-59549f9bcc-r578q -n ingress-yarviz-prod
kubectl describe pod/yarviz-mssql-deployment-59549f9bcc-5v565 -n ingress-yarviz-prod
kubecl get all -n ingress-yarviz-prod
kubectl get all -n ingress-yarviz-prod
df -i
top
kubectl get all -n ingress-yarviz-prod
cd Yarviz-Prod/
kubectl delete -f deployment-sqlserver-yarviz.yaml 
kubectl get all -n ingress-yarviz-prod
top
kubectl get all -n ingress-yarviz-prod
kubectl get all -n ingress-rds
kubectl get all --all-namespace=true
kubectl get pods --all-namespace=true
kubectl get pods
kubectl get namespace
top
az account set --subscription 0ffeefdc-476a-483a-9096-05fdbfa2304a
az aks get-credentials --resource-group microservicioRG --name cluster-microservices
top
ls
cd RDS-Prod/
ls
cd ..
git init
git add.
