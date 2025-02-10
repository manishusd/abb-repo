Error Types and Solutions:

1) ErrImagePull: The image `node-crud-api:1.0.1` is not available in the Azure Container Registry (ACR).  

2) Liveness/Readiness Probe Failure: The endpoints `/health/liveness` or `/health/readiness` are not defined in the application, causing the probe to fail.  

3) Gateway Timeout: An inbound Network Security Group (NSG) rule was blocking access to the API on the AKS node. The issue was resolved by updating the rule.


1) PS C:\Users\manis\OneDrive\Desktop> kubectl get pods
NAME                             READY   STATUS             RESTARTS   AGE
node-crud-api-5cc5998595-85wtc   0/1     ImagePullBackOff   0          17s
PS C:\Users\manis\OneDrive\Desktop> kubectl describe pod node-crud-api-5cc5998595-85wtc
Name:             node-crud-api-5cc5998595-85wtc
Namespace:        platform-dev
Priority:         0
Service Account:  default
Node:             aks-default-19498542-vmss000000/10.0.1.4
Start Time:       Sun, 09 Feb 2025 16:47:09 +0530
Labels:           app=node-crud-api
                  pod-template-hash=5cc5998595
Annotations:      <none>
Status:           Pending
IP:               10.0.1.11
IPs:
  IP:           10.0.1.11
Controlled By:  ReplicaSet/node-crud-api-5cc5998595
Containers:
  node-crud-api:
    Container ID:
    Image:          abbacr.azurecr.io/node-crud-api:1.0.1
    Image ID:
    Port:           3000/TCP
    Host Port:      0/TCP
    State:          Waiting
      Reason:       ImagePullBackOff
    Ready:          False
    Restart Count:  0
    Environment:
      NODE_ENV:  dev
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-rd4hw (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True
  Initialized                 True
  Ready                       False
  ContainersReady             False
  PodScheduled                True
Volumes:
  kube-api-access-rd4hw:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason     Age                From               Message
  ----     ------     ----               ----               -------
  Normal   Scheduled  39s                default-scheduler  Successfully assigned platform-dev/node-crud-api-5cc5998595-85wtc to aks-default-19498542-vmss000000
  Normal   BackOff    15s (x2 over 37s)  kubelet            Back-off pulling image "abbacr.azurecr.io/node-crud-api:1.0.1"
  Warning  Failed     15s (x2 over 37s)  kubelet            Error: ImagePullBackOff
  Normal   Pulling    4s (x3 over 39s)   kubelet            Pulling image "abbacr.azurecr.io/node-crud-api:1.0.1"
  Warning  Failed     4s (x3 over 38s)   kubelet            Failed to pull image "abbacr.azurecr.io/node-crud-api:1.0.1": failed to pull and unpack image "abbacr.azurecr.io/node-crud-api:1.0.1": failed to resolve reference "abbacr.azurecr.io/node-crud-api:1.0.1": failed to authorize: failed to fetch anonymous token: unexpected status from GET request to https://abbacr.azurecr.io/oauth2/token?scope=repository%3Anode-crud-api%3Apull&service=abbacr.azurecr.io: 401 Unauthorized
  Warning  Failed     4s (x3 over 38s)   kubelet            Error: ErrImagePull



  2) PS C:\Users\manis> kubectl describe pod node-crud-api-6f4d474c4d-xnpsh
Name:             node-crud-api-6f4d474c4d-xnpsh
Namespace:        platform-dev
Priority:         0
Service Account:  default
Node:             aks-default-19498542-vmss000000/10.0.1.4
Start Time:       Mon, 10 Feb 2025 00:13:36 +0530
Labels:           app=node-crud-api
                  pod-template-hash=6f4d474c4d
Annotations:      <none>
Status:           Running
IP:               10.0.1.27
IPs:
  IP:           10.0.1.27
Controlled By:  ReplicaSet/node-crud-api-6f4d474c4d
Containers:
  node-crud-api:
    Container ID:   containerd://a59a8cf3f5b14977d1b7a9a6650b854a13c8557c98e5854246c924098ba4d5a9
    Image:          abbacr.azurecr.io/node-crud-api:1.0.0
    Image ID:       abbacr.azurecr.io/node-crud-api@sha256:8548befa46c46bab7e70817ed6a8a9c589cd006cd01b8a542d2e11f693204e46
    Port:           3000/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Mon, 10 Feb 2025 00:13:37 +0530
    Ready:          False
    Restart Count:  0
    Liveness:       http-get http://:3000/health/liveness delay=10s timeout=1s period=15s #success=1 #failure=3
    Readiness:      http-get http://:3000/health/readiness delay=5s timeout=1s period=10s #success=1 #failure=3
    Environment:
      NODE_ENV:  dev
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-z75vt (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True
  Initialized                 True
  Ready                       False
  ContainersReady             False
  PodScheduled                True
Volumes:
  kube-api-access-z75vt:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason     Age               From               Message
  ----     ------     ----              ----               -------
  Normal   Scheduled  25s               default-scheduler  Successfully assigned platform-dev/node-crud-api-6f4d474c4d-xnpsh to aks-default-19498542-vmss000000
  Normal   Pulled     25s               kubelet            Container image "abbacr.azurecr.io/node-crud-api:1.0.0" already present on machine
  Normal   Created    25s               kubelet            Created container node-crud-api
  Normal   Started    25s               kubelet            Started container node-crud-api
  Warning  Unhealthy  10s               kubelet            Liveness probe failed: HTTP probe failed with statuscode: 404
  Warning  Unhealthy  5s (x2 over 15s)  kubelet            Readiness probe failed: HTTP probe failed with statuscode: 404