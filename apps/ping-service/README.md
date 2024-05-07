A Kubernetes deployment that provides a list of cluster URLs and loops through them reporting thier status.

# Build
docker build -t nethopper/ping-service .

docker push nethopper/ping-service:latest

## unit test in docker
docker run --rm --env PING_URLS=https://google.com nethopper/ping-service

## unit test in k8s
kubectl apply -f github.com/nethopper2/cloudflow/manifests/ping-service/ping-service.yaml

# Demo
  - Deploy ping-service and tail pod logs
  - Observe errors pinging frontend service
  - Deploy https://github.com/nethopper2/cloudflow/tree/master/manifests/demoapp/frontend
  - Observe successful ping of frontend svc

## Other URLs
  - Add csv URLs to env.value in ping-service.yaml to test other URLs

# Misc
  - prometheus-service.yaml moved to cloudflow/manifests/ping-service/ping-service.yaml

