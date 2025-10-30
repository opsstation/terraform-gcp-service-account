output "account_email" {
  value       = module.service-account.account_email
  description = "The e-mail address of the service account."
}

output "account_unique_id" {
  value       = module.service-account.account_unique_id
  description = "The unique id of the service account."
}

output "account_display_name" {
  value       = module.service-account.account_display_name
  description = "The display name of the service account."
}

output "key_id" {
  value       = module.service-account.key_id
  description = "An identifier for the key_id resource from the service account keys module."
}

output "public_key" {
  value       = module.service-account.public_key
  description = "The public key, base64 encoded from the service account keys module."
}

output "private_key" {
  value       = module.service-account.private_key
  description = "The private key in JSON format, base64 encoded from the service account keys module."
  sensitive   = true
}

output "valid_after" {
  value       = module.service-account.valid_after
  description = "The key can be used after this timestamp from the service account keys module."
}

output "valid_before" {
  value       = module.service-account.valid_before
  description = "The key can be used before this timestamp from the service account keys module."
}