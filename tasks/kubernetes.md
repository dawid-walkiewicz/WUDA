# Create helm chart for the project

## Minimum must have
- [x] Definition for the front-end back-end and database deployments
- [x] possibility to modify docker images (tags, repositories)
- [x] possibility to manage number of replicas for each deployment
- [ ] workflow for deploying the helm chart to a kubernetes cluster

## Nice to see and have
- [x] declaration for readiness and livness probes
- [x] making db deployment optional
- [x] allowing to read configuration variables from configmaps / secrets
- [ ] Possibility to setup ingress for remote access on the cluster
