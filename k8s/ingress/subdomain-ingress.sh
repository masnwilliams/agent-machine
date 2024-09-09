#!/bin/bash

NAMESPACE=$1

cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ${NAMESPACE}-webui-ingress
  namespace: ${NAMESPACE}
  annotations:
    # networking.gke.io/managed-certificates: "eidolon-cert"  # Optional for SSL
spec:
  ingressClassName: "gce"
  rules:
  - host: ${NAMESPACE}.getfathom.ai
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: eidolon-webui-service
            port:
              number: 3000
EOF
