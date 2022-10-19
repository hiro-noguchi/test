provider "google" {
}

data "google_client_config" "default" {
  provider = google
}

data "google_service_account_access_token" "default" {
  provider               = google
  target_service_account = "terraform@civic-planet-343505.iam.gserviceaccount.com"
  scopes                 = "civic-planet-343505"
  lifetime               = "300s"
}

provider "google" {
  alias        = "impersonated"
  access_token = data.google_service_account_access_token.default.access_token
  project      = "civic-planet-343505"
  region       = "asia-northeast1"
}

provider "google-beta" {
  access_token = data.google_service_account_access_token.default.access_token
  project      = "civic-planet-343505"
  region       = "asia-northeast1"
}

terraform {
  required_version = "1.0.0"
  backend "gcs" {
    bucket = "td-state-test"
  }
}
