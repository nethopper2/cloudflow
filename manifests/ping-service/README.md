README

- ping-service source code is in cloudflow/apps/ping-service. See README there for details.

**ping-service-deploy.yaml**
  - ping-service deployment is serving prometheus metrics to http://<pod ip address>:2112/metrics

**ping-service.yaml**
  - Service whose endpoint in ping-service pod port 2112

**ping-service-servicemonitor.yaml**
  - Prometheus CRD that enables the Service to be discovered and scraped
