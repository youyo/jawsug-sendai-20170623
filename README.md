# JAWS-UG Sendai

## CI Service

- Wercker : https://app.wercker.com/youyo/jawsug-sendai-20170623/runs

## Terraform

```
export AWS_ACCESS_KEY_ID=xxx
export AWS_SECRET_ACCESS_KEY=yyy
export TF_VAR_env=development

terraform init -backend=true -backend-config="bucket=${TF_VAR_env}-jawsug-sendai-terraform-tfstate"
terraform validate
terraform plan
terraform apply
```
