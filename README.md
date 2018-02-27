# hello-helm
Sample app deployed with helm

# Deploy
```
helm install hello-helm-chart -n hello-helm --set image.tag=a9f053dabf7f1ff642caddabc1de2d7904a6f62a,image.repository=cplee/hello-helm,service.type=NodePort,service.nodeport=30000
```