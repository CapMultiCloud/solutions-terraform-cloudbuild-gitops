# Service Account to be used by Cloud Function
resource "google_service_account" "cap_cloud_sa" {
    account_id   = "cap-cloud-${var.env}"
    display_name = "Cloud Function Service Account"
}

# Set sample role for CF SA
resource "google_project_iam_member" "cap_cloud_sa_editor" {
  role    = "roles/editor"
  member  = "serviceAccount:${google_service_account.cap_cloud_sa.email}"
}

# Service Account to be used by MIG
resource "google_service_account" "cap_mig_sa" {
    account_id   = "cap-mig-sa-${var.env}"
    display_name = "MIG Service Account to access Secret Manager and Storage Bucket"
}

# Set role Storage Object Admin for cap_mig_sa
resource "google_project_iam_member" "storage-object-sa-mig" {
  role    = "roles/storage.objectAdmin"
  member  = "serviceAccount:${google_service_account.cap_mig_sa.email}"
}

# Set role Secret Manager Accessor for cap_mig_sa
resource "google_project_iam_member" "secret-manager-sa-mig" {
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.cap_mig_sa.email}"
}

# Set role Secret Manager Viewer for cap_mig_sa
resource "google_project_iam_member" "secret-viewer-sa-mig" {
  role    = "roles/secretmanager.viewer"
  member  = "serviceAccount:${google_service_account.cap_mig_sa.email}"
}