A Kubernetes deployment that provides a list of cluster URLs and loops through them reporting thier status.

# Build
docker build -t nethopper/ping-service .

docker push nethopper/ping-service:latest

### unit test
docker run --rm --env PING_URLS=https://google.com nethopper/ping-service

# Demo
  - Deploy ping-service and tail pod logs
  - Observe errors pinging frontend service
  - Deploy https://github.com/nethopper2/cloudflow/tree/master/manifests/demoapp/frontend
  - Observe successful ping of frontend svc

### Other URLs
  - Add csv URLs to env.value in ping-service.yaml to test other URLs 

