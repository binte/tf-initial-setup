# Exit when any command returns a failure status.
set -e

# Read arguments
environment=$1

# Initialize Terraform.
terraform init -input=false -backend-config="environments/$environment/$environment.backend.tfvars"

# Apply the Terraform plan.
terraform apply -input=false -auto-approve -var-file="environments/$environment/$environment.tfvars"
