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

## view in prometheus (in-cluster)
  - There are two metrics exhausted to prometheus:
      + ping_service_success_cnt
      + ping_service_error_cnt

  NOTE: pod IP address is 172.17.0.11
  
  ```
  $curl http://172.17.0.11:2112/metrics | grep ping
  ping_service_error_cnt 7
  ping_service_success_cnt 284
  ```
## Other URLs
  - Add csv URLs to env.value in ping-service.yaml to test other URLs

# Misc
  - prometheus-service.yaml moved to cloudflow/manifests/ping-service/ping-service.yaml

# Debug Notes
  - Check Prometheus Config (this example uses the ping-service ServiceMonitor)
      + get pod IP and curl it's metrics endpoint at port 9090
      + **NOTE**: Can be done from agent pod for clusters w/o public ip 
      ```
      $ k describe pod prometheus-<cluster-name>-observabi-prometheus-0
      
      $ curl http://172.17.0.7:9090/metrics
      ```

      + Verify your app is being scraped
      ```
      $ curl http://172.17.0.7:9090/metrics | grep ping
      ```
      Following output means your service has been discovered by Prometheus  
      ```
      prometheus_sd_discovered_targets{config="serviceMonitor/default/ping-service-servicemonitor/0",name="scrape"} 19
      ```

      Non-zero values in the following output means it's collecting metrics from your app
      ```
      prometheus_target_metadata_cache_bytes{scrape_job="serviceMonitor/default/ping-service-servicemonitor/0"} 1876
      
      prometheus_target_metadata_cache_entries{scrape_job="serviceMonitor/default/ping-service-servicemonitor/0"} 38
      ```
# Developer Notes
  - Requires a Deployment, Service, and ServiceMonitor objects
  - The http endpoint of the Service is a port in the Deployment pod which is exhausting metrics to <pod-ip:port>/metrics
  - The ServiceMonitor is a Prometheus CRD that enable a prometheus server to discover the Service
  - The **release** annotation in the ServiceMonitor manifest must match the prometheus server **release** annotation in the Prometheus server ($k get prometheus -o yaml)
  - Didn't have to do anything to view in a custom Hub Grafana dashboard
      + New Dashboard->Add Visualization
      + Select cluster as Data Source
      + Add a metric in the Metric dropdown
      + To add additional metrics, Click **+ Query"** and repeat last step



  


