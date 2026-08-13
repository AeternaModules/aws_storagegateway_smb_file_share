variable "storagegateway_smb_file_shares" {
  description = <<EOT
Map of storagegateway_smb_file_shares, attributes below
Required:
    - gateway_arn
    - location_arn
    - role_arn
Optional:
    - access_based_enumeration
    - admin_user_list
    - audit_destination_arn
    - authentication
    - bucket_region
    - case_sensitivity
    - default_storage_class
    - file_share_name
    - guess_mime_type_enabled
    - invalid_user_list
    - kms_encrypted
    - kms_key_arn
    - notification_policy
    - object_acl
    - oplocks_enabled
    - read_only
    - region
    - requester_pays
    - smb_acl_enabled
    - tags
    - tags_all
    - valid_user_list
    - vpc_endpoint_dns_name
    - cache_attributes (block):
        - cache_stale_timeout_in_seconds (optional)
EOT

  type = map(object({
    gateway_arn              = string
    location_arn             = string
    role_arn                 = string
    tags_all                 = optional(map(string))
    tags                     = optional(map(string))
    smb_acl_enabled          = optional(bool)
    requester_pays           = optional(bool)
    region                   = optional(string)
    read_only                = optional(bool)
    oplocks_enabled          = optional(bool)
    object_acl               = optional(string)
    notification_policy      = optional(string)
    kms_key_arn              = optional(string)
    invalid_user_list        = optional(set(string))
    valid_user_list          = optional(set(string))
    guess_mime_type_enabled  = optional(bool)
    file_share_name          = optional(string)
    default_storage_class    = optional(string)
    case_sensitivity         = optional(string)
    bucket_region            = optional(string)
    authentication           = optional(string)
    audit_destination_arn    = optional(string)
    admin_user_list          = optional(set(string))
    access_based_enumeration = optional(bool)
    kms_encrypted            = optional(bool)
    vpc_endpoint_dns_name    = optional(string)
    cache_attributes = optional(object({
      cache_stale_timeout_in_seconds = optional(number)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.storagegateway_smb_file_shares : (
        v.cache_attributes == null || (v.cache_attributes.cache_stale_timeout_in_seconds == null || (v.cache_attributes.cache_stale_timeout_in_seconds >= 300 && v.cache_attributes.cache_stale_timeout_in_seconds <= 2592000))
      )
    ])
    error_message = "must be between 300 and 2592000"
  }
  validation {
    condition = alltrue([
      for k, v in var.storagegateway_smb_file_shares : (
        v.notification_policy == null || ((can(regex("^\\{[\\w\\s:\\{\\}\\[\\]\"]*}$", v.notification_policy))) && (length(v.notification_policy) >= 2 && length(v.notification_policy) <= 100))
      )
    ])
    error_message = "all of: must be between 2 and 100 characters"
  }
  # Note: 9 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

