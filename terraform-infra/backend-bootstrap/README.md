# Backend Bootstrap

This directory contains Terraform configuration to create the infrastructure needed for remote state management.

## What This Creates

1. **S3 Bucket** (`goal-tracker-terraform-state`)
   - Versioning enabled (keeps history of state files)
   - Server-side encryption (AES256)
   - Public access blocked
   - TLS enforcement via bucket policy

2. **DynamoDB Table** (`goal-tracker-terraform-locks`)
   - Used for state locking to prevent concurrent modifications
   - Pay-per-request billing (cost-effective for occasional use)

## Usage

### Step 1: Create Backend Infrastructure

```bash
cd backend-bootstrap
terraform init
terraform plan
terraform apply
```

### Step 2: Note the Outputs

After applying, you'll see output similar to:

```
s3_bucket_name = "goal-tracker-terraform-state"
dynamodb_table_name = "goal-tracker-terraform-locks"
```

### Step 3: Enable Remote Backend in Your Environment

1. Open `environments/dev/backend.tf`
2. Uncomment the backend block
3. Run the following to migrate your state:

```bash
cd ../environments/dev
terraform init -migrate-state
```

4. Type `yes` when prompted to copy the existing state to the new backend

## Important Notes

- ⚠️ **Run this only once** - The S3 bucket and DynamoDB table only need to be created once per AWS account/project
- 🔒 **prevent_destroy is enabled** - To delete these resources, you must first remove the `lifecycle` blocks
- 💰 **Costs** - S3 and DynamoDB costs are minimal (typically < $1/month for state management)
- 🔐 **Do NOT use remote backend for this bootstrap** - This configuration intentionally uses local state

## Cleanup

If you need to destroy the backend infrastructure:

1. First, migrate all environments back to local state
2. Remove `prevent_destroy` from `resources.tf`
3. Run `terraform destroy`
