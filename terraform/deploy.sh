#!/bin/bash

# GPT-RAG Terraform Deployment Script
# This script deploys the GPT-RAG infrastructure using Terraform

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if required tools are installed
check_prerequisites() {
    print_status "Checking prerequisites..."
    
    # Check if Terraform is installed
    if ! command -v terraform &> /dev/null; then
        print_error "Terraform is not installed. Please install Terraform first."
        exit 1
    fi
    
    # Check if Azure CLI is installed
    if ! command -v az &> /dev/null; then
        print_error "Azure CLI is not installed. Please install Azure CLI first."
        exit 1
    fi
    
    # Check if user is logged into Azure
    if ! az account show &> /dev/null; then
        print_error "You are not logged into Azure. Please run 'az login' first."
        exit 1
    fi
    
    print_success "Prerequisites check passed"
}

# Function to initialize Terraform
init_terraform() {
    print_status "Initializing Terraform..."
    terraform init
    print_success "Terraform initialized"
}

# Function to validate Terraform configuration
validate_terraform() {
    print_status "Validating Terraform configuration..."
    terraform validate
    print_success "Terraform configuration is valid"
}

# Function to plan Terraform deployment
plan_terraform() {
    print_status "Creating Terraform plan..."
    terraform plan -out=tfplan
    print_success "Terraform plan created"
}

# Function to apply Terraform deployment
apply_terraform() {
    print_status "Applying Terraform plan..."
    terraform apply tfplan
    print_success "Terraform deployment completed"
}

# Function to display outputs
show_outputs() {
    print_status "Deployment outputs:"
    terraform output
}

# Function to create terraform.tfvars if it doesn't exist
setup_tfvars() {
    if [ ! -f "terraform.tfvars" ]; then
        print_warning "terraform.tfvars not found. Creating from example..."
        cp terraform.tfvars.example terraform.tfvars
        print_warning "Please edit terraform.tfvars with your specific values before continuing."
        read -p "Press Enter to continue after editing terraform.tfvars..."
    fi
}

# Main deployment function
main() {
    print_status "Starting GPT-RAG Terraform deployment"
    
    # Navigate to terraform directory
    cd "$(dirname "$0")"
    
    # Check prerequisites
    check_prerequisites
    
    # Setup terraform.tfvars
    setup_tfvars
    
    # Initialize Terraform
    init_terraform
    
    # Validate configuration
    validate_terraform
    
    # Create plan
    plan_terraform
    
    # Ask for confirmation
    echo
    print_warning "This will deploy GPT-RAG infrastructure to Azure."
    read -p "Do you want to continue? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_status "Deployment cancelled"
        exit 0
    fi
    
    # Apply deployment
    apply_terraform
    
    # Show outputs
    echo
    show_outputs
    
    echo
    print_success "GPT-RAG deployment completed successfully!"
    print_status "You can access the frontend at the FRONTEND_URL shown above."
}

# Run main function
main "$@"
