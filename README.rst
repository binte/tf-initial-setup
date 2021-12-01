**********************************
**Simple initial Terraform setup**
**********************************

This repo contains everything that is needed for setting up terraform to be deployed via CI and CI/CD pipelines.

The corresponding project on Azure DevOps can be found `here <https://dev.azure.com/Coutinhos/Terraform-Initial-Setup>`_

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

1. Create Service Principal with contributor rights at the corresponding TF target subscription (replace the subscription ID, as per the instructions in the command).

.. code-block:: bash

    ./sp_create.sh SP-EUR-TerraSetup "subscription id goes here"

2. Deploy dedicated resource group, storage account name and container for the Terraform state (replace the subscription ID, as per the instructions in the command).

.. code-block:: bash
    
    ./tf_storage.sh SUBSCRIPTION_ID="subscription id goes here" RESOURCE_GROUP_NAME="RG-EUR-TerraSetup-Storage" STORAGE_ACCOUNT_NAME="saeurterrasetupstorage" CONTAINER_NAME="tfstate" LOCATION="westeurope"

3. Validate that the SPN has the necessary rights, while testing out if the remote TF state can be accessed locally. The current repo has already the terraform folder structure necessary for the following commands to be used. 

.. code-block:: bash
    
    terraform init -input=false -backend-config="environments/dev/dev.backend.tfvars"
    terraform plan -var-file="environments/dev/dev.tfvars"
.. code-block::

4. Setup CI pipeline.
    #. On the first execution, authorisation shall be granted to the pipeline, because of the need to read values from the Pipeline group library.
..

5. Set main branch policies, enforcing:
    #. ... a mandatory review,
    #. ... running the CI pipeline as a build validation step.
..

6. Create the CI/CD pipeline that applies the plan.
    #. On the first execution, authorisation shall be granted to the pipeline, because of the need to read values from the Pipeline group library.

--------
**TODO**
--------

1. Steps 4) and 5) are not yet done.

2. Update script responsible for creating the service principal, so that it can target scopes other than a subscription
