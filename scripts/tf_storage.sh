#!/bin/bash
## 
## Purpose: Create the necessary infrastructure (Resource Group with storage account and BLOB container)
## to host the Terraform state for a certain application
##
## Usage: ./tf_storage.sh SUBSCRIPTION_ID="name of the existing subscription, where the resources will be created" RESOURCE_GROUP_NAME="name of an existing RG, or name to assign to a RG that will be created" STORAGE_ACCOUNT_NAME="name to assign to the storage account that will be created" CONTAINER_NAME="name to assign to the BLOB container" LOCATION="resource location"
##


# Parse the script arguments
for ARGUMENT in "$@"
do

    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)   

    case "$KEY" in
            SUBSCRIPTION_ID)      SUBSCRIPTION_ID=${VALUE} ;;
            RESOURCE_GROUP_NAME)  RESOURCE_GROUP_NAME=${VALUE} ;;
            STORAGE_ACCOUNT_NAME) STORAGE_ACCOUNT_NAME=${VALUE} ;;   
            CONTAINER_NAME)       CONTAINER_NAME=${VALUE} ;;
            LOCATION)             LOCATION=${VALUE} ;;
            *)   
    esac

done

# Create resource group if it doesn't exist
if [ ! "az group exists --subscription $SUBSCRIPTION_ID -g $RESOURCE_GROUP_NAME" ]; then
  az group create --name $RESOURCE_GROUP_NAME --location $LOCATION
fi

# Create storage account
az storage account create --subscription $SUBSCRIPTION_ID --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Get storage account key
ACCOUNT_KEY=$(az storage account keys list --subscription $SUBSCRIPTION_ID --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)

# Create blob container
az storage container create --subscription $SUBSCRIPTION_ID --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY

echo "storage_account_name: $STORAGE_ACCOUNT_NAME"
echo "container_name: $CONTAINER_NAME"
echo "access_key: $ACCOUNT_KEY"
