#!/bin/bash

################################################################################
# Script Name: vault_copy_secret.sh
# Description: This script copies secret data from one HashiCorp Vault namespace
#              to another.
# Author: [Rajesh Allun]
# Date: [22-02-2024]
################################################################################

## Pre-requisites

Before executing the script, ensure the following steps are completed:

1. **Login to HashiCorp Vault**: Ensure you are logged in to your HashiCorp Vault instance. You can do this using the Vault CLI with the `vault login` command.

export VAULT_ADDR=<vault_address>
vault login

Refer https://developer.hashicorp.com/vault/docs/commands/login for more details.

2. **Set Environment Variables**: The script requires the source and target namespaces and the kv_path to be set as environment variables. You can do this with the `export` command in your terminal:

export source_namespace=<source-namespace>
export target_namespace=<target-namespace>
export kv_path=<kv-path>

Replace <source-namespace>, <target-namespace>, and <kv-path> with your actual values.

3. Need read and write permission to source and target namespace in hashicorp vault.

# Usage
After setting up the pre-requisites, you can run the script with the following command:

./vault_copy_secret.sh
