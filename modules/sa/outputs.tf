output "cf_sa" {
  value = "${google_service_account.cap_cloud_sa.email}"
}

output "mig_sa" {
  value = "${google_service_account.cap_mig_sa.email}"
}