# Exit when any command returns a failure status.
set -e

# Initialize Terraform.
terraform init -input=false -backend-config="environments/$environment/$environment.backend.tfvars"

# Apply the Terraform plan.
terraform apply -input=false -auto-approve -var-file="environments/$environment/$environment.tfvars"
