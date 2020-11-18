output "storage" {
  value = "${module.storage.bucket}"
}

output "startup_script" {
  value = "${module.storage.startup-script}"
}

output "cf_sa" {
  value = "${module.sa.cf_sa}"
}

output "cf_clientAgeVal" {
  value = "${module.cloudfunction.cf_clientAgeVal}"
}

output "cf_duePayVal" {
  value = "${module.cloudfunction.cf_duePayVal}"
}

output "cf_effortRateNewCredVal" {
  value = "${module.cloudfunction.cf_effortRateNewCred}"
}

output "cf_effortRateTotalCredVal" {
  value = "${module.cloudfunction.cf_effortRateTotalCredVal}"
}

output "cf_jsonToBase64" {
  value = "${module.cloudfunction.cf_jsonToBase64}"
}