variable "name" {
  type        = list(string)
  default     = [""]
  description = "Name of the resource. Provided by the client when the resource is created. "
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment"]
  description = "Label order, e.g. sequence of application name and environment `name`,`environment`,'attribute' [`webserver`,`qa`,`devops`,`public`,] ."
}

variable "managedby" {
  type        = string
  default     = "opsstation"
  description = "ManagedBy,opsstation"
}

variable "repository" {
  type        = string
  default     = ""
  description = "Terraform current module repo"
}

variable "public_key_type" {
  type        = string
  default     = "TYPE_X509_PEM_FILE"
  description = " (Optional) The output format of the public key requested. TYPE_X509_PEM_FILE is the default output format."
}

variable "private_key_type" {
  type        = string
  default     = "TYPE_GOOGLE_CREDENTIALS_FILE"
  description = "(Optional) The output format of the private key. TYPE_GOOGLE_CREDENTIALS_FILE is the default output format."
}

variable "key_algorithm" {
  type        = string
  default     = "KEY_ALG_RSA_2048"
  description = " (Optional) The algorithm used to generate the key. KEY_ALG_RSA_2048 is the default algorithm. "
}

variable "keepers" {
  type        = map(string)
  default     = null
  description = "Arbitrary map of values that, when changed, will trigger a new key to be generated."
}

variable "grant_billing_role" {
  type        = bool
  default     = false
  description = "Grant billing user role."
}

variable "billing_account_id" {
  type        = string
  default     = ""
  description = "If assigning billing role, specificy a billing account (default is to assign at the organizational level)."
}

variable "grant_xpn_roles" {
  type        = bool
  default     = true
  description = "Grant roles for shared VPC management."
}

variable "org_id" {
  type        = string
  default     = ""
  description = "Id of the organization for org-level roles."
}

variable "service_account" {
  type = list(object({
    name          = string
    display_name  = string
    description   = string
    roles         = list(string)
    generate_keys = bool
  }))

  description = "A list of service accounts with their attributes, including name, display_name, description, roles, and generate_keys."
}