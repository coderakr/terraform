# Variable Precedence in Terraform
****
In Terraform, variables can be defined in multiple ways, and they have a specific order of precedence. The order of precedence determines which value will be used when multiple sources provide a value for the same variable. The order of precedence is as follows:
1. **Environment Variables**: If a variable is set as an environment variable, it will take precedence over other sources. The environment variable should be named in the format `TF_VAR_<variable_name>`.
example: For a variable named `s3_bucket_environment`, you can set an environment variable like this:
   ```bash
   export TF_VAR_s3_bucket_environment=prod
   ```
2. **Terraform CLI Flags**: When running Terraform commands, you can pass variable values using the `-var` flag. This will override any values set in variable definitions or environment variables.
example: You can pass a variable value like this:
   ```bash
   terraform apply -var="s3_bucket_environment=prod"
   ```
3. **Terraform Variable Definitions Files**: You can define variables in `.tfvars` files or any file with a `.tfvars.json` extension. These files can be specified using the `-var-file` flag when running Terraform commands.
example: You can create a file named `terraform.tfvars` with the following content:
   ```hcl
   s3_bucket_environment = "prod"
   ```
   Then, you can apply the configuration using:
   ```bash
   terraform apply -var-file="terraform.tfvars"
   ```
