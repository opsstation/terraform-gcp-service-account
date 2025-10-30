# 🏗️ Terraform-google-service-account
# Google Cloud Infrastructure Provisioning with Terraform

[![OpsStation](https://img.shields.io/badge/Made%20by-OpsStation-blue?style=flat-square&logo=terraform)](https://www.opsstation.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Terraform](https://img.shields.io/badge/Terraform-1.13%2B-purple.svg?logo=terraform)](#)
[![CI](https://github.com/OpsStation/terraform-gcp-service-account/actions/workflows/ci.yml/badge.svg)](https://github.com/OpsStation/terraform-gcp-service-account/actions/workflows/ci.yml)
[![Latest Release](https://img.shields.io/github/release/opsstation/terraform-gcp-service-account.svg)](https://github.com/opsstation/terraform-gcp-service-account/releases/latest)

> 🌩️ **A production-grade, reusable GCP service-account module by [OpsStation](https://www.opsstation.com)**
> Designed for reliability, performance, and security — following GCP networking best practices.
---

## 🏢 About OpsStation

**OpsStation** delivers **Cloud & DevOps excellence** for modern teams:
- 🚀 **Infrastructure Automation** with Terraform, Ansible & Kubernetes
- 💰 **Cost Optimization** via scaling & right-sizing
- 🛡️ **Security & Compliance** baked into CI/CD pipelines
- ⚙️ **Fully Managed Operations** across GCP, Azure, and AWS

> 💡 Need enterprise-grade DevOps automation?
> 👉 Visit [**www.opsstation.com**](https://www.opsstation.com) or email **hello@opsstation.com**


# 🔐 Terraform GCP Service Account Management Module

This Terraform configuration automates the creation and management of **Google Cloud Service Accounts** along with their IAM bindings, project roles, billing access, and optional key generation.  
It’s designed to work seamlessly with the **OpsStation Multicloud Labels** module and integrates cleanly into your multi-environment GCP infrastructure.

---

## 🌟 Features

🔥 **Terraform GCP Service Account Management Features**

- ✅ Automatically **creates and manages GCP service accounts**
- ✅ Assigns **IAM roles** at the project, organization, and billing levels
- ✅ Supports **dynamic role mapping** using for-loops and locals
- ✅ Optionally **grants billing and XPN roles** based on org or account inputs
- ✅ Integrates with [OpsStation Multicloud Labels](https://registry.terraform.io/modules/opsstation/labels/multicloud/latest)
- ✅ Optionally **generates and manages service account keys**
- ✅ Built for **multi-account, multi-role deployments** (Dev / Stage / Prod)
- ✅ Follows **Google Cloud best practices** for IAM and security



## 🧩 Module Structure

| Component                            | Description                                                       |
|--------------------------------------|-------------------------------------------------------------------|
| `google_service_account`             | Creates one or more service accounts                              |
| `google_service_account_iam_binding` | Binds IAM roles directly to each service account                  |
| `google_project_iam_member`          | Grants project-level roles to service accounts                    |
| `google_billing_account_iam_member`  | Optionally grants billing roles                                   |
| `google_organization_iam_member`     | Optionally grants organization-level roles (XPN, Viewer, Billing) |
| `google_service_account_key`         | Optionally creates and manages service account keys               |
| `module "labels"`                    | Adds consistent OpsStation labels and metadata                    |



## ⚙️ Usage Example
### 🧱  single_service_account Example
```hcl
module "service-account" {
  source          = "opsstation/service-account/gcp"
  version         = "1.0.1"
  service_account = [
    {
      name          = "test"
      display_name  = "Single Service Account"
      description   = "Single Account Description"
      roles         = ["roles/viewer"] # Single role
      generate_keys = false
    }
  ]
}

```
### 🧱  multiple_service_accounts Example
```hcl
module "service-account" {
  source          = "opsstation/service-account/gcp"
  version         = "1.0.1"
  service_account = [
    {
      name          = "svc-account-first"
      display_name  = "First Service Account"
      description   = "This is the first service account"
      roles         = ["roles/editor", "roles/viewer", "roles/owner"] # Multiple roles
      generate_keys = true
    },
    {
      name          = "svc-account-second"
      display_name  = "Second Service Account"
      description   = "This is the second service account"
      roles         = ["roles/editor"] # Single role
      generate_keys = true
    }
  ]
}

```

### 🔑 Outputs (GCP Service Account Module)

| **Name**               | **Description**                                                    |
|------------------------|--------------------------------------------------------------------|
| `account_email`        | The email addresses of all created service accounts.               |
| `account_unique_id`    | The unique IDs assigned to each service account.                   |
| `account_display_name` | The display names of the created service accounts.                 |
| `key_id`               | The unique identifiers for the generated service account keys.     |
| `public_key`           | The public keys (base64 encoded) for the generated keys.           |
| `private_key`          | The private keys (base64 encoded, sensitive output).               |
| `valid_after`          | The timestamps from which each key becomes valid.                  |
| `valid_before`         | The timestamps after which each key expires.                       |

---

💡 **Note:**  
Sensitive outputs such as `private_key` should be handled securely and never stored in version control.  
For production environments, consider using a **Secret Manager** or **Vault** for key management.

---
### ☁️ Tag Normalization Rules (GCP)

| Cloud   | Case         | Allowed Characters | Example                             |
|---------|--------------|--------------------|-------------------------------------|
| **GCP** | TitleCase    | Any                | `Name`, `Environment`, `CostCenter` |

---

### 💙 Maintained by [OpsStation](https://www.opsstation.com)
> OpsStation — Simplifying Cloud, Securing Scale.
