resource "aws_storagegateway_smb_file_share" "storagegateway_smb_file_shares" {
  for_each = var.storagegateway_smb_file_shares

  gateway_arn              = each.value.gateway_arn
  location_arn             = each.value.location_arn
  role_arn                 = each.value.role_arn
  tags_all                 = each.value.tags_all
  tags                     = each.value.tags
  smb_acl_enabled          = each.value.smb_acl_enabled
  requester_pays           = each.value.requester_pays
  region                   = each.value.region
  read_only                = each.value.read_only
  oplocks_enabled          = each.value.oplocks_enabled
  object_acl               = each.value.object_acl
  notification_policy      = each.value.notification_policy
  kms_key_arn              = each.value.kms_key_arn
  invalid_user_list        = each.value.invalid_user_list
  valid_user_list          = each.value.valid_user_list
  guess_mime_type_enabled  = each.value.guess_mime_type_enabled
  file_share_name          = each.value.file_share_name
  default_storage_class    = each.value.default_storage_class
  case_sensitivity         = each.value.case_sensitivity
  bucket_region            = each.value.bucket_region
  authentication           = each.value.authentication
  audit_destination_arn    = each.value.audit_destination_arn
  admin_user_list          = each.value.admin_user_list
  access_based_enumeration = each.value.access_based_enumeration
  kms_encrypted            = each.value.kms_encrypted
  vpc_endpoint_dns_name    = each.value.vpc_endpoint_dns_name

  dynamic "cache_attributes" {
    for_each = each.value.cache_attributes != null ? [each.value.cache_attributes] : []
    content {
      cache_stale_timeout_in_seconds = cache_attributes.value.cache_stale_timeout_in_seconds
    }
  }
}

