# GPT-RAG Terraform Deployment Script (PowerShell)
# This script deploys the GPT-RAG infrastructure using Terraform

param(
    [switch]$SkipPlan,
    [switch]$AutoApprove
)

# Function to write colored output
function Write-Status {
    param($Message)
    Write-Host "[INFO] $Message" -ForegroundColor Blue
}

function Write-Success {
    param($Message)
    Write-Host "[SUCCESS] $Message" -ForegroundColor Green
}

function Write-Warning {
    param($Message)
    Write-Host "[WARNING] $Message" -ForegroundColor Yellow
}

function Write-Error {
    param($Message)
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

# Function to check prerequisites
function Test-Prerequisites {
    Write-Status "Checking prerequisites..."
    
    # Check if Terraform is installed
    if (!(Get-Command terraform -ErrorAction SilentlyContinue)) {
        Write-Error "Terraform is not installed. Please install Terraform first."
        exit 1
    }
    
    # Check if Azure CLI is installed
    if (!(Get-Command az -ErrorAction SilentlyContinue)) {
        Write-Error "Azure CLI is not installed. Please install Azure CLI first."
        exit 1
    }
    
    # Check if user is logged into Azure
    try {
        az account show | Out-Null
    }
    catch {
        Write-Error "You are not logged into Azure. Please run 'az login' first."
        exit 1
    }
    
    Write-Success "Prerequisites check passed"
}

# Function to initialize Terraform
function Initialize-Terraform {
    Write-Status "Initializing Terraform..."
    terraform init
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Terraform initialization failed"
        exit 1
    }
    Write-Success "Terraform initialized"
}

# Function to validate Terraform configuration
function Test-TerraformConfiguration {
    Write-Status "Validating Terraform configuration..."
    terraform validate
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Terraform validation failed"
        exit 1
    }
    Write-Success "Terraform configuration is valid"
}

# Function to plan Terraform deployment
function New-TerraformPlan {
    Write-Status "Creating Terraform plan..."
    terraform plan -out=tfplan
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Terraform plan failed"
        exit 1
    }
    Write-Success "Terraform plan created"
}

# Function to apply Terraform deployment
function Invoke-TerraformApply {
    Write-Status "Applying Terraform plan..."
    terraform apply tfplan
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Terraform apply failed"
        exit 1
    }
    Write-Success "Terraform deployment completed"
}

# Function to display outputs
function Show-TerraformOutputs {
    Write-Status "Deployment outputs:"
    terraform output
}

# Function to setup terraform.tfvars
function Set-TerraformVariables {
    if (!(Test-Path "terraform.tfvars")) {
        Write-Warning "terraform.tfvars not found. Creating from example..."
        Copy-Item "terraform.tfvars.example" "terraform.tfvars"
        Write-Warning "Please edit terraform.tfvars with your specific values before continuing."
        
        if (!$AutoApprove) {
            Read-Host "Press Enter to continue after editing terraform.tfvars"
        }
    }
}

# Main deployment function
function Start-Deployment {
    Write-Status "Starting GPT-RAG Terraform deployment"
    
    # Navigate to script directory
    Set-Location $PSScriptRoot
    
    # Check prerequisites
    Test-Prerequisites
    
    # Setup terraform.tfvars
    Set-TerraformVariables
    
    # Initialize Terraform
    Initialize-Terraform
    
    # Validate configuration
    Test-TerraformConfiguration
    
    # Create plan (unless skipped)
    if (!$SkipPlan) {
        New-TerraformPlan
    }
    
    # Ask for confirmation (unless auto-approved)
    if (!$AutoApprove) {
        Write-Host ""
        Write-Warning "This will deploy GPT-RAG infrastructure to Azure."
        $confirmation = Read-Host "Do you want to continue? (y/N)"
        if ($confirmation -notmatch '^[Yy]$') {
            Write-Status "Deployment cancelled"
            exit 0
        }
    }
    
    # Apply deployment
    if ($SkipPlan) {
        Write-Status "Applying Terraform configuration directly..."
        terraform apply -auto-approve
    }
    else {
        Invoke-TerraformApply
    }
    
    # Show outputs
    Write-Host ""
    Show-TerraformOutputs
    
    Write-Host ""
    Write-Success "GPT-RAG deployment completed successfully!"
    Write-Status "You can access the frontend at the FRONTEND_URL shown above."
}

# Run main function
try {
    Start-Deployment
}
catch {
    Write-Error "Deployment failed: $($_.Exception.Message)"
    exit 1
}
