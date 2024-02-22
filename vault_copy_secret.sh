#!/bin/bash

export_secrets() {
  local path=$1
  # Remove trailing slash from the path
  path=${path%/}

  # List all secrets in the path
  export VAULT_NAMESPACE=$source_namespace

  # Exception handling for listing secrets
  secrets=$(vault kv list -format=json $path | jq -r '.[]') || { echo "Failed to list secrets in $path"; return 1; }

  # Loop through each secret
  for secret in $secrets
  do
    # Check if the secret is a subpath
    if [[ $secret == */ ]]; then
      # Recursively read the secrets in the subpath
      export_secrets "$path/$secret"
    else
      # Get the secret data
      export VAULT_NAMESPACE=$source_namespace
      secret_data=$(vault kv get -format=json $path/$secret | jq -r '.data.data') || { echo "Failed to get secret data for $path/$secret"; return 1; }

      # Set the VAULT_NAMESPACE environment variable to the destination namespace
      export VAULT_NAMESPACE=$target_namespace

      # Write the secret data to the new path
      echo $secret_data | vault kv put $path/$secret - || { echo "Failed to write secret in target namespace kv path $path/$secret"; return 1; }
    fi
  done 
}

# Start exporting the secrets
export_secrets $kv_path

