***********************************
**Setting initial Terraform setup**
***********************************

This repo contains everything that is needed for setting up terraform to be deployed via CI and CI/CD pipelines.

-----------
**Cloning**
-----------

Clone the repo:

.. code-block:: bash

    $ git clone https://github.com/binte/tf-initial-setup YOUR_PROJECT_DIR/

-----------------
**PREREQUISITES**
-----------------

- Install terraform
- Setup VS Code to develop terraform with an extension, for syntax highlighting
- Define the scope of the deployment (Subscription, RG, ...). However, the current status of development assumes that the scope will be a subscription

----------------
**STEP BY STEP**
----------------

1. Create Service Principal with contributor rights at the corresponding TF target subscription

.. code-block:: bash

    ./sp_create.sh SP-EUR-TerraSetup 50c5d3ee-889a-46f9-a6d8-539bdbbfdc5c

2. Deploy dedicated resource group, storage account name and container for the Terraform state

.. code-block:: bash
    
    ./tf_storage.sh SUBSCRIPTION_ID="50c5d3ee-889a-46f9-a6d8-539bdbbfdc5c" RESOURCE_GROUP_NAME="RG-EUR-TerraSetup-Storage" STORAGE_ACCOUNT_NAME="saeurterrasetupstorage" CONTAINER_NAME="tfstate" LOCATION="westeurope"

3. Validate that the SPN has the necessary rights, and test out the remote TF state, while configuring the development environment so that the remote state can be accessed when developing locally

.. code-block:: bash
    
    terraform init -input=false -backend-config="environments/dev/dev.backend.tfvars"
    terraform plan -var-file="environments/dev/dev.tfvars"

4. Setup CI pipeline
    On the first execution, authorisation shall be granted to the pipeline, because of the need to read values from the Pipeline group library.

5. Set main branch policies, enforcing:
    #.a mandatory review,
    #.running the CI pipeline as a build validation step.

6. Create the CI/CD pipeline that applies the plan.
    On the first execution, authorisation shall be granted to the pipeline, because of the need to read values from the Pipeline group library.

--------
**TODO**
--------

1. Steps 4) and 5) are not yet done.
