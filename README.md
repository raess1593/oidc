# 🔐 AWS OIDC Terraform Infrastructure

A secure, production-ready infrastructure as code project demonstrating **OpenID Connect (OIDC)** authentication between GitHub Actions and AWS, with automated Terraform deployments.

## ✨ Features

- 🔒 **OIDC Authentication** - Secure, keyless authentication from GitHub Actions to AWS
- 🏗️ **Infrastructure as Code** - Complete infrastructure management with Terraform
- 🤖 **CI/CD Automation** - GitHub Actions pipeline for automated deployments
- 🗄️ **Remote State** - Secure Terraform state stored in S3 with DynamoDB locking
- ☁️ **AWS Native** - Leverages AWS services for scalability and reliability

## 🛠️ Tech Stack

| Component | Technology | Version |
|-----------|-----------|---------|
| IaC Framework | Terraform | 1.0.0+ |
| Cloud Provider | AWS | 4.x |
| CI/CD Platform | GitHub Actions | Latest |
| Authentication | OIDC | Native |
| State Backend | S3 + DynamoDB | - |

## 📋 Prerequisites

- AWS Account with appropriate IAM permissions
- Terraform >= 0.14
- Git and GitHub repository access
- OIDC provider configured in AWS

## 🚀 Quick Start

### 1️⃣ Clone the Repository
```bash
git clone <repository-url>
cd oidc
```

### 2️⃣ Configure AWS Credentials
Set up your AWS OIDC provider and IAM role:
```bash
export AWS_REGION=us-east-1
export ACTIONS_ROLE_ARN=arn:aws:iam::ACCOUNT_ID:role/github-actions-role
```

### 3️⃣ Initialize Terraform
```bash
terraform init
```

### 4️⃣ Review & Plan Deployment
```bash
terraform plan
```

### 5️⃣ Apply Infrastructure
```bash
terraform apply
```

## 📁 Project Structure

```
.
├── main.tf              # Primary infrastructure configuration
├── providers.tf         # AWS provider & backend setup
├── .github/
│   └── workflows/
│       └── main.yml     # GitHub Actions CI/CD pipeline
└── .gitignore          # Git ignore rules
```

## 🔄 GitHub Actions Workflow

The automated pipeline:
- ✅ Triggers on push/PR to `main` branch
- 🔐 Authenticates to AWS via OIDC (no credentials!)
- 📊 Runs `terraform plan` for validation
- 🚀 Auto-applies on main branch push

```yaml
# Key workflow steps
1. Checkout code
2. Configure AWS credentials via OIDC
3. Initialize Terraform
4. Plan infrastructure changes
5. Apply (main branch only)
```

## 📦 Infrastructure Components

- **S3 Bucket** - GitHub Actions deployment artifacts storage
- **Remote State** - Terraform state backend with encryption
- **DynamoDB** - State locking mechanism
- **IAM Roles** - Secure GitHub Actions to AWS integration

## 🔐 Security Best Practices

✓ OIDC for keyless authentication  
✓ Encrypted S3 state backend  
✓ DynamoDB state locking  
✓ IAM least-privilege roles  
✓ Automated deployments only from `main` branch  

## 📚 Learn More

- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest)
- [GitHub OIDC Documentation](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect)
- [AWS IAM OIDC Provider](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc.html)

---

Author: @raess1593
