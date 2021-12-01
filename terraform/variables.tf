variable "location" {
  description = "Resource location"
  default     = "westeurope"
}

variable "region_acronym" {
  description = "Acronym for the continent where resource is going to be deployed"
  default     = "EUR"
}

variable "environment" {
  description = "Environment where the resources will be deployed"
  default     = "DEV"
}
