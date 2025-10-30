provider "google" {
  project = "opsstation-474608"
  region  = "asia-northeast1"
  zone    = "asia-northeast1-a"
}


#####==============================================================================
##### Single-service-account module call .
#####==============================================================================
module "service-account" {
  source = "./../../"
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