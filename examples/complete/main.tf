module "aci_config_export" {
  source = "netascode/config-export/aci"

  name            = "EXP1"
  description     = "My Description"
  format          = "xml"
  remote_location = "REMOTE1"
  scheduler       = "SCHEDULER1"
}
