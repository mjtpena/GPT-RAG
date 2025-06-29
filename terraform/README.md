# GPT-RAG Terraform Infrastructure

This directory contains Terraform configuration files to deploy the GPT-RAG (Retrieval-Augmented Generation) infrastructure on Microsoft Azure. This is a complete conversion of the original Bicep templates to Terraform.

## Architecture Overview

The Terraform configuration deploys the following Azure resources:

### Core Services
- **Azure OpenAI Service** - For GPT models and embeddings
- **Azure AI Services** - For document intelligence and speech services
- **Azure Cognitive Search** - For vector and hybrid search capabilities
- **Azure Cosmos DB** - For storing conversations and datasource metadata
- **Azure Storage Account** - For document storage and function apps
- **Azure Key Vault** - For secure storage of secrets and keys

### Compute Resources
- **Azure App Service Plan** - Linux-based hosting plan
- **Azure Function Apps** (2) - Orchestrator and data ingestion functions
- **Azure App Service** - Frontend web application
- **Azure Application Insights** - Application monitoring and logging

### Network Infrastructure (Optional)
- **Virtual Network** - Private network with multiple subnets
- **Private Endpoints** - For secure, private connectivity
- **Private DNS Zones** - For internal name resolution
- **Azure Bastion** - Secure VM access (when network isolation is enabled)

### Additional Services
- **Load Testing** - Azure Load Testing service (optional)
- **Virtual Machine** - Management VM for network isolated deployments (optional)

## Prerequisites

Before deploying with Terraform, ensure you have:

1. **Terraform** (>= 1.0) installed
2. **Azure CLI** installed and authenticated (`az login`)
3. **Azure subscription** with appropriate permissions
4. **Resource quotas** available for Azure OpenAI, Cognitive Search, and other services

### Required Azure Permissions

Your Azure account needs the following roles/permissions:
- `Contributor` role on the subscription or resource group
- `User Access Administrator` role (for assigning managed identity permissions)
- Permission to create service principals and role assignments

## Quick Start

1. **Clone and navigate to the terraform directory:**
   ```bash
   cd terraform/
   ```

2. **Copy and customize the variables file:**
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

3. **Edit terraform.tfvars with your specific values:**
   ```bash
   # Basic required settings
   environment_name = "dev"
   location         = "East US"
   vm_user_initial_password = "YourSecurePassword123!"
   ```

4. **Run the deployment script:**
   ```bash
   # For Linux/macOS
   ./deploy.sh
   
   # For Windows PowerShell
   .\deploy.ps1
   ```

   Or deploy manually:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## Configuration Options

### Basic Deployment
For a simple deployment with public endpoints:

```hcl
environment_name = "dev"
location         = "East US"
network_isolation = false
deploy_vm        = false
vm_user_initial_password = "SecurePassword123!"
```

### Network Isolated Deployment
For a production deployment with private endpoints:

```hcl
environment_name = "prod"
location         = "East US"
network_isolation = true
deploy_vm        = true
vm_user_initial_password = "VerySecurePassword123!"
vm_user_name     = "gptrag"
```

### Azure OpenAI Configuration
Customize the AI models and deployments:

```hcl
chat_gpt_model_name      = "gpt-4o"
chat_gpt_model_version   = "2024-11-20"
embeddings_model_name    = "text-embedding-3-large"
embeddings_vector_size   = 3072
retrieval_approach       = "hybrid"
use_semantic_reranking   = true
```

## Module Structure

The Terraform configuration is organized into modules:

- **`networking/`** - VNet, subnets, and private DNS zones
- **`storage/`** - Storage accounts and containers
- **`keyvault/`** - Key Vault and secret management
- **`cosmosdb/`** - Cosmos DB account and containers
- **`ai_services/`** - Azure OpenAI and Cognitive Services
- **`search/`** - Azure Cognitive Search service
- **`compute/`** - App Service Plan, Function Apps, and Web App
- **`private_endpoints/`** - Private endpoints for all services
- **`iam/`** - Role assignments and permissions

## Network Isolation

When `network_isolation = true`, the deployment creates:

- A Virtual Network with multiple subnets
- Private endpoints for all Azure services
- Private DNS zones for name resolution
- Network security groups and routing
- Optional VM with Bastion for management access

This configuration is suitable for production environments requiring enhanced security.

## Outputs

After deployment, Terraform provides outputs including:

- **FRONTEND_URL** - URL to access the web application
- **ORCHESTRATOR_ENDPOINT** - Function app endpoint
- **AZURE_RESOURCE_GROUP_NAME** - Resource group name
- **AZURE_STORAGE_ACCOUNT_NAME** - Storage account for documents
- All resource names and identifiers

## Post-Deployment

After Terraform completes:

1. **Upload documents** to the storage container for indexing
2. **Access the frontend** using the provided URL
3. **Monitor** the application through Application Insights
4. **Scale** the App Service Plan as needed

## Resource Reuse

The configuration supports reusing existing Azure resources through the `azure_reuse_config` variable. This is useful for:

- Sharing Azure OpenAI instances across environments
- Reusing existing Virtual Networks
- Leveraging existing monitoring infrastructure

Example:
```hcl
azure_reuse_config = {
  aoai_reuse                        = true
  existing_aoai_resource_group_name = "shared-rg"
  existing_aoai_name               = "shared-openai"
  vnet_reuse                       = true
  existing_vnet_resource_group_name = "network-rg"
  existing_vnet_name               = "shared-vnet"
}
```

## Cost Optimization

To optimize costs:

1. **Use Standard tier** for non-production environments
2. **Enable autoscaling** for Function Apps
3. **Set appropriate retention** for logs and storage
4. **Use free tier** for Cognitive Search in development
5. **Consider reserved instances** for production workloads

## Troubleshooting

### Common Issues

1. **Quota Exceeded**: Ensure your subscription has available quota for Azure OpenAI and other services
2. **Permissions**: Verify your account has Contributor and User Access Administrator roles
3. **Resource Names**: Azure resource names must be globally unique
4. **Region Availability**: Ensure selected region supports all required services

### Debugging

Enable Terraform debugging:
```bash
export TF_LOG=DEBUG
terraform apply
```

Check Azure activity logs:
```bash
az monitor activity-log list --resource-group <rg-name>
```

## Security Considerations

- **Secrets Management**: All secrets are stored in Azure Key Vault
- **Managed Identities**: Services use managed identities for authentication
- **Network Security**: Private endpoints provide secure connectivity
- **Access Control**: RBAC is used for fine-grained permissions
- **Encryption**: Data is encrypted at rest and in transit

## Migration from Bicep

If migrating from the original Bicep deployment:

1. **Export existing state** from Azure
2. **Import resources** into Terraform state
3. **Update configurations** to match existing resources
4. **Plan carefully** to avoid resource conflicts

## Contributing

When modifying the Terraform configuration:

1. **Follow Terraform best practices**
2. **Update module documentation**
3. **Test in development environment**
4. **Validate with `terraform validate`**
5. **Format with `terraform fmt`**

## Support

For issues and questions:

1. **Check Terraform logs** for detailed error messages
2. **Review Azure portal** for resource status
3. **Consult Azure documentation** for service-specific issues
4. **Use Azure support** for Azure platform issues

## Version Compatibility

- **Terraform**: >= 1.0
- **AzureRM Provider**: ~> 3.0
- **Azure CLI**: >= 2.30
- **PowerShell**: >= 5.1 (for Windows deployment script)

## License

This Terraform configuration follows the same license as the original GPT-RAG project.
