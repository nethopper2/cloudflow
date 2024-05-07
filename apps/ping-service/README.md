A Kubernetes deployment that pings a list of URLs every 5 seconds exhausting prometheus ok/error metrics accordingly.

The deployment manifest for the application is: github.com/nethopper2/cloudflow/manifests/ping-service/ping-service.yaml.

Default test URL in application manifest is for the frontend service (cloudflow/manifests/demoapp/frontend).

# Build
docker build -t nethopper/ping-service .
docker push nethopper/ping-service:latest

## unit test in docker
docker run --rm --env PING_URLS=https://google.com nethopper/ping-service

## unit test in k8s
kubectl apply -f github.com/nethopper2/cloudflow/manifests/ping-service/ping-service.yaml

# Demo
  - Deploy https://github.com/nethopper2/cloudflow/tree/master/manifests/demoapp/frontend

## view in pod logs
  - tail pod logs
  - Observe successes/errors pinging frontend service

## view in prometheus
  - There are two metrics exhausted to prometheus:
      + ping_service_success_cnt
      + ping_service_error_cnt

## Other URLs
  - Add csv URLs to env.value in ping-service.yaml to test other URLs

# Misc
  - prometheus-service.yaml moved to cloudflow/manifests/ping-service/ping-service.yaml

