module "labels" {
  source      = "opsstation/labels/multicloud"
  version     = "1.0.0"
  name        = var.name[0]
  environment = var.environment
  label_order = var.label_order
  managedby   = var.managedby
  repository  = var.repository
}

data "google_client_config" "current" {}

locals {
  account_billing = var.grant_billing_role && var.billing_account_id != ""
  org_billing     = var.grant_billing_role && var.billing_account_id == "" && var.org_id != ""

  xpn   = var.grant_xpn_roles && var.org_id != ""
  names = [for account in var.service_account : account.name] # Extract names

  service_account_roles = flatten([
    for account in var.service_account : [
      for role in account.roles : {
        account_name = account.name
        role         = role
      }
    ]
  ])

  name_role_pairs = [
    for pair in local.service_account_roles : {
      name = pair.account_name
      role = pair.role
    }
  ]
}

#####==============================================================================
##### Allows management of a Google Cloud service account.
#####==============================================================================
resource "google_service_account" "service_accounts" {
  for_each = { for account in var.service_account : account.name => account }

  account_id   = format("svc-%s", each.key)
  display_name = each.value.display_name
  description  = each.value.description
  project      = data.google_client_config.current.project
}

#####==============================================================================
##### Managing IAM roles for the service accounts.
#####==============================================================================
resource "google_service_account_iam_binding" "admin_account_iam" {
  for_each = {
    for sa in var.service_account : sa.name => sa
  }

  service_account_id = format("projects/%s/serviceAccounts/%s",
    data.google_client_config.current.project,
    google_service_account.service_accounts[each.key].email
  )

  role = each.value.roles[0]

  members = [
    for role in each.value.roles : format("serviceAccount:%s", google_service_account.service_accounts[each.key].email)
  ]
}

resource "google_project_iam_member" "project_roles" {
  for_each = {
    for pair in local.name_role_pairs :
    "${pair.name}-${pair.role}" => pair if pair.role != "" # Ensure unique keys by combining name and role
  }

  project = data.google_client_config.current.project
  role    = each.value.role
  member  = format("serviceAccount:%s", google_service_account.service_accounts[each.value.name].email)
}


resource "google_organization_iam_member" "billing_user" {
  for_each = local.org_billing ? local.names : toset([]) # Use local.names instead

  org_id = var.org_id
  role   = "roles/billing.user"
  member = format("serviceAccount:%s", google_service_account.service_accounts[each.value].email) # Use each.value to access the service account
}

resource "google_billing_account_iam_member" "billing_user" {
  for_each = local.account_billing ? local.names : toset([]) # Use local.names instead

  billing_account_id = var.billing_account_id
  role               = "roles/billing.user"
  member             = format("serviceAccount:%s", google_service_account.service_accounts[each.value].email) # Use each.value to access the service account
}

resource "google_organization_iam_member" "xpn_admin" {
  for_each = local.xpn ? local.names : toset([]) # Use local.names instead

  org_id = var.org_id
  role   = "roles/compute.xpnAdmin"
  member = format("serviceAccount:%s", google_service_account.service_accounts[each.value].email) # Use each.value to access the service account
}

resource "google_organization_iam_member" "organization_viewer" {
  for_each = local.xpn ? local.names : toset([]) # Use local.names instead

  org_id = var.org_id
  role   = "roles/resourcemanager.organizationViewer"
  member = format("serviceAccount:%s", google_service_account.service_accounts[each.value].email) # Use each.value to access the service account
}

#####==============================================================================
##### Creates and manages service account keys, which allow the use of a service
##### account with Google Cloud.
#####==============================================================================
resource "google_service_account_key" "mykey" {
  for_each = { for account in var.service_account : account.name => account if account.generate_keys }

  service_account_id = google_service_account.service_accounts[each.key].email
  public_key_type    = var.public_key_type
  private_key_type   = var.private_key_type
  keepers            = var.keepers
  key_algorithm      = var.key_algorithm
}