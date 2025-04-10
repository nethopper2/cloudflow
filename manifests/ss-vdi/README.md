## KAOPS StatefulSets demo to show how Kubernetes supports VDI (Virtual Decktop Instances)

### Use the following procedure

1. Copy the yaml below into a file called \<user\>.yaml
2. Replace All "drbob" with the name of your \<user\>
3. Save the file to this directory (cloudflow/manifests/ss-vdi)
4. Either wait 2 minutes for KAOPS to sync with this git repo, or manually sync the app in KAOPS
5. Persistant data is stored at /data.  Store something there, like 'echo hi > /data/temp.txt'
6. To turn off the VDI (and conserve Kubernetes CPU and memory resources and cost), change "replicas: 1" to "replicas: 0"
7. To turn back on the VDI, change "replicas: 0" to "replicas: 1".
8. Notice that the persistent data is still available (more /data/temp.txt)
9. To delete the VDI, remove the \<user\>.yaml file

```bash
apiVersion: v1
kind: Namespace
metadata:
  name: drbob
  labels:
    name: drbob
---
apiVersion: v1
kind: Service
metadata:
  name: ubuntu
  namespace: drbob
  labels:
    app: ubuntu
spec:
  ports:
  - port: 22
    name: ssh
  # Headless service: no cluster IP so that each pod gets a DNS entry.
  #clusterIP: None
  type: NodePort
  selector:
    app: ubuntu
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: ubuntu-statefulset
  namespace: drbob
spec:
  serviceName: "ubuntu"   # Refers to the headless service above.
  replicas: 1             # Number of pods.
  selector:
    matchLabels:
      app: ubuntu
  template:
    metadata:
#    namespace: drbob
      labels:
        app: ubuntu
    spec:
      terminationGracePeriodSeconds: 10
      containers:
      - name: ubuntu
        image: ubuntu:20.04
        command: [ "/bin/bash", "-c", "--" ] #working command
        args: [ "echo 'root' | sh -c 'echo 'root:root' | chpasswd' && apt-get update && apt-get install -y openssh-server && echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config &&
 mkdir -p /run/sshd && /usr/sbin/sshd -D; while true; do sleep 5; done;" ] #working loop command
        # The container runs indefinitely.
        volumeMounts:
        - name: ubuntu-data
          mountPath: /data  # Mounting the persistent storage.
  volumeClaimTemplates:
  - metadata:
      name: ubuntu-data  # This name is referenced in volumeMounts.
    spec:
      accessModes: ["ReadWriteOnce"]
      storageClassName: standard  # Ensure that this matches your cluster's StorageClass.
      resources:
        requests:
          storage: 1Mi
```
