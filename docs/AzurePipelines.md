# Azure Pipelines

1. Create Azure Container Registry
2. Create Azure Kubernetes Service
3. Create Service Connections
   Go to DevOps -> Project Settings -> Service Connections
   1. Add ACR
   2. Add AKS
4. Create Environment
   1. Add Environment
      Go to Pipelines -> Environments -> New environment
   2. Add Deployment
      Go to new Environment -> Add resource -> Add Kubernetes Cluster
