variable "environment" {
  default = "Develop"
}

variable "project_name" {
  default = "{{project_name}}"
}

variable "project_region" {
  default     = "{{region}}"
  description = "region of gcp instance"
}

variable "ports" {
  default     = "{{port}}"
  description = "allowed_ports"
}

variable "allowed_ips" {
  default     = "{{ip_range}}"
  description = "allowed_inbound_ips"
}

variable "project_zone" {
  default     = "{{zone}}"
  description = "zone of gcp instance"
}

variable "org_name" {
  type    = string
  default = "{{org_name}}"
}

variable "credentials" {
  default = "{{credential_file.json}}"
}

# To allow for variable substitution in a script where
# file output is needed.
variable "heredoc" {
  type    = string
  default = "<<"
}

variable "confluent_cloud_api_key" {
  type    = string
  default = "{{api_key}}"
}

variable "network-subnet-cidr" {
  type    = string
  default = "{{ip_address(s)}}"
}


variable "confluent_cloud_api_secret" {
  type    = string
  default = "{{api_secret}}"
}


