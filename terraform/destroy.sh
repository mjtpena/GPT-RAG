#!/bin/bash

# GPT-RAG Terraform Destroy Script
# This script destroys the GPT-RAG infrastructure deployed with Terraform

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

# Function to check if Terraform is initialized
check_terraform_state() {
    if [ ! -f ".terraform/terraform.tfstate" ] && [ ! -f "terraform.tfstate" ]; then
        print_error "No Terraform state found. Nothing to destroy."
        exit 1
    fi
}

# Function to show what will be destroyed
show_destroy_plan() {
    print_status "Creating destroy plan..."
    terraform plan -destroy
    print_success "Destroy plan created"
}

# Function to destroy infrastructure
destroy_infrastructure() {
    print_status "Destroying GPT-RAG infrastructure..."
    terraform destroy -auto-approve
    print_success "Infrastructure destroyed successfully"
}

# Function to clean up Terraform files
cleanup_terraform_files() {
    print_status "Cleaning up Terraform files..."
    
    # Remove plan files
    if [ -f "tfplan" ]; then
        rm tfplan
        print_status "Removed tfplan"
    fi
    
    # Ask about removing .terraform directory
    read -p "Remove .terraform directory? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf .terraform
        print_status "Removed .terraform directory"
    fi
    
    # Ask about removing state files
    read -p "Remove terraform.tfstate files? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -f terraform.tfstate*
        print_status "Removed state files"
    fi
}

# Main destroy function
main() {
    print_warning "GPT-RAG Infrastructure Destruction Script"
    print_warning "This will permanently delete all deployed Azure resources!"
    
    # Navigate to terraform directory
    cd "$(dirname "$0")"
    
    # Check if there's anything to destroy
    check_terraform_state
    
    # Show what will be destroyed
    echo
    print_status "The following resources will be destroyed:"
    show_destroy_plan
    
    # Final confirmation
    echo
    print_error "WARNING: This action cannot be undone!"
    print_error "All data in the deployed resources will be permanently lost!"
    echo
    read -p "Are you absolutely sure you want to destroy all resources? Type 'yes' to confirm: " confirmation
    
    if [ "$confirmation" != "yes" ]; then
        print_status "Destruction cancelled"
        exit 0
    fi
    
    # Ask for resource group name verification
    echo
    print_status "For additional safety, please verify the resource group name."
    if [ -f "terraform.tfvars" ]; then
        rg_name=$(grep -E "^resource_group_name\s*=" terraform.tfvars | sed 's/.*=\s*"\([^"]*\)".*/\1/' || echo "")
        if [ -n "$rg_name" ]; then
            print_status "Resource group from tfvars: $rg_name"
        fi
    fi
    
    # Get current resource group from state
    current_rg=$(terraform show -json 2>/dev/null | jq -r '.values.root_module.resources[] | select(.type=="azurerm_resource_group") | .values.name' 2>/dev/null || echo "")
    if [ -n "$current_rg" ]; then
        print_status "Resource group from state: $current_rg"
        echo
        read -p "Type the resource group name '$current_rg' to confirm: " rg_confirmation
        if [ "$rg_confirmation" != "$current_rg" ]; then
            print_error "Resource group name does not match. Destruction cancelled."
            exit 1
        fi
    fi
    
    # Destroy infrastructure
    echo
    destroy_infrastructure
    
    # Clean up files
    echo
    cleanup_terraform_files
    
    echo
    print_success "GPT-RAG infrastructure destruction completed!"
    print_status "All Azure resources have been deleted."
}

# Show usage if help is requested
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    echo "GPT-RAG Terraform Destroy Script"
    echo
    echo "This script will destroy all GPT-RAG infrastructure deployed with Terraform."
    echo
    echo "Usage: $0"
    echo
    echo "The script will:"
    echo "1. Show a plan of what will be destroyed"
    echo "2. Ask for confirmation"
    echo "3. Destroy all resources"
    echo "4. Optionally clean up Terraform files"
    echo
    echo "WARNING: This action is irreversible and will delete all data!"
    exit 0
fi

# Run main function
main "$@"
