output "account_email" {
  value       = join(", ", [for sa in google_service_account.service_accounts : sa.email])
  description = "The e-mail address of the service account."
}

output "account_unique_id" {
  value       = join(", ", [for sa in google_service_account.service_accounts : sa.unique_id])
  description = "The unique id of the service account."
}

output "account_display_name" {
  value       = join(", ", [for sa in google_service_account.service_accounts : sa.display_name])
  description = "The display name of the service account."
}

output "key_id" {
  value       = join(", ", [for k in google_service_account_key.mykey : k.id])
  description = "An identifier for the key_id resource."
}

output "public_key" {
  value       = join(", ", [for k in google_service_account_key.mykey : k.public_key])
  description = "The public key, base64 encoded."
}

output "private_key" {
  value       = join(", ", [for k in google_service_account_key.mykey : k.private_key])
  description = "The private key in JSON format, base64 encoded."
  sensitive   = true
}

output "valid_after" {
  value       = join(", ", [for k in google_service_account_key.mykey : k.valid_after])
  description = "The key can be used after this timestamp."
}

output "valid_before" {
  value       = join(", ", [for k in google_service_account_key.mykey : k.valid_before])
  description = "The key can be used before this timestamp."
}