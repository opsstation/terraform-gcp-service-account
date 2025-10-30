provider "google" {
  project = "opsstation-474608"
  region  = "asia-northeast1"
  zone    = "asia-northeast1-a"
}

#####==============================================================================
##### Multiple-service-account module call .
#####==============================================================================
module "service-account" {
  source = "./../../"
  service_account = [
    {
      name          = "svc-account-first"
      display_name  = "First Service Account"
      description   = "This is the first service account"
      roles         = ["roles/editor", "roles/viewer", "roles/owner"] # Multiple roles
      generate_keys = false
    },
    {
      name          = "svc-account-second"
      display_name  = "Second Service Account"
      description   = "This is the second service account"
      roles         = ["roles/editor"] # Single role
      generate_keys = false
    }
  ]
}