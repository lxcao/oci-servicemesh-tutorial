#deploy application
kubectl create namespace bookinfo

kubectl apply -f bookinfo-v1.yaml

kubectl get svc bookinfo-ingress -n bookinfo

#config service mesh
kubectl label namespace bookinfo servicemesh.oci.oracle.com/sidecar-injection=enabled

kubectl apply -f meshify-bookinfo-v1.yaml

kubectl apply -f bind-bookinfo-v1.yaml

kubectl get services -n bookinfo

kubectl get svc bookinfo-ingress -n bookinfo

curl http://<EXTERNAL-IP>

