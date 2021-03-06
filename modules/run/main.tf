##### Credit Approval - Webapp #####



# Creating service account 

resource "google_service_account" "sa-credit-approval-app" {
    account_id   = "sa-credit-approval-app"
    display_name = "Service Account for Credit Approval App"
}

# Adding iam role for service account 

resource "google_project_iam_member" "sa-credit-approval-app-pubsub-publisher" {
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:${google_service_account.sa-credit-approval-app.email}"
}


resource "google_cloud_run_service" "credit-approval-app" {
    name     = "credit-approval-app"
    location = "${var.region}"
    autogenerate_revision_name = true
    template {
        spec {
            containers {
                image = "eu.gcr.io/${var.project}/gcr/creditwebapp"  
                resources {
                    limits = {
                      memory = "2048Mi"
                      cpu    = "1000m"
                    }
                  }
                }
            
            timeout_seconds = 800
            }
        metadata {
            annotations = {
                    "autoscaling.knative.dev/minScale" = "0",
                    "autoscaling.knative.dev/maxScale" = "1"
                }
            }
        }
    traffic {
        percent = 100
        latest_revision = true
        }

}


data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.credit-approval-app.location
  project     = google_cloud_run_service.credit-approval-app.project
  service     = google_cloud_run_service.credit-approval-app.name

  policy_data = data.google_iam_policy.noauth.policy_data
  
  depends_on = [google_cloud_run_service.credit-approval-app]
}