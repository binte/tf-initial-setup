#!/bin/bash
## 
## Purpose: Create a service principal on Azure AD, and assign contributor rights to it on a given subscription. 
## The script then outputs the subscription ID and the service principal secret, client ID and tenant ID.
##
## For the script to work when running from git Bash on Windows, it is necessary to export MSYS_NO_PATHCONV=1. The
## current script version does that when creating the service principal with az ad sp create-for-rbac. 
##
## Usage: ./sp_create.sh {name-of-the-service-principal} {target-subscription-id}
##


SP_NAME=$1
SP_SUBSCRIPTION_ID=$2

# Create a service principal with Contributor role and output the service principal password (also called client secret)
SP_CLIENT_SECRET=$(MSYS_NO_PATHCONV=1 az ad sp create-for-rbac \
  --name $SP_NAME \
  --role Contributor \
  --scopes "/subscriptions/$SP_SUBSCRIPTION_ID" \
  --query password \
  --output tsv)

# Get the client ID (also called application ID)
SP_CLIENT_ID=$(az ad app list --display-name $SP_NAME --query [].appId -o tsv)

# Get the tenant id
SP_TENANT_ID=$(az account show --query tenantId -o tsv)

# Output the service principal's details and credentials
echo "Subscription ID: $SP_SUBSCRIPTION_ID"
echo "Service principal client secret: $SP_CLIENT_SECRET"
echo "Service principal client ID: $SP_CLIENT_ID"
echo "Service principal tenant ID: $SP_TENANT_ID"
