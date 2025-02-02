terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.17.0"
    }
  }
}

provider "google" {
  region  = "us-central1"
  project = "linen-office-448103-r9"
}
