output "run_prod" {
  value = "ssh -i .ssh/private_key.pem debian@${google_compute_address.static_ip_producer.address}"
}

output "run_cons" {
  value = "ssh -i .ssh/private_key.pem debian@${google_compute_address.static_ip_consumer.address}"
}
