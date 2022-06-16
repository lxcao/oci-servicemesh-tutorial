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

#Setup Logging Service to Store your Logs
oci logging log-group create --compartment-id ocid1.compartment.oc1..aaaaaaaayjcsmu5ii7ac3kncp5qlbsslaj7irtc3mo4oco22w7ucsiq3atmq --display-name bookinfo --profile specialist2 --auth security_token

oci logging log create --log-group-id ocid1.loggroup.oc1.ap-singapore-1.amaaaaaacuco5yqahgngmt5xkqsh5vr32uf4r3eexdrgfbrzb6hdiskrfs6q --display-name bookinfo-logs --log-type custom --profile specialist2 --auth security_token

oci logging agent-configuration create --compartment-id ocid1.compartment.oc1..aaaaaaaayjcsmu5ii7ac3kncp5qlbsslaj7irtc3mo4oco22w7ucsiq3atmq --is-enabled true --service-configuration file:///Users/caolingxin/documents/workspaces/oci-projects/oci-servicemesh-tutorial/logconfig.json --display-name bookInfoLoggingAgent --description "Custom agent config for mesh" --group-association '{"groupList": ["ocid1.dynamicgroup.oc1..aaaaaaaaosz4fhyqdms3ze5wljrbyq7q7ueiglodnx6heqs2ansb33cdt2bq"]}'  --profile specialist2 --auth security_token

#Add monitor to mesh
kubectl create namespace monitoring

kubectl apply -f grafana.yaml

kubectl get svc grafana -n monitoring

