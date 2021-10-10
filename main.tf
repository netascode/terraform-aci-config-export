resource "aci_rest" "configExportP" {
  dn         = "uni/fabric/configexp-${var.name}"
  class_name = "configExportP"
  content = {
    name   = var.name
    descr  = var.description
    format = var.format
  }
}

resource "aci_rest" "configRsRemotePath" {
  dn         = "${aci_rest.configExportP.dn}/rsRemotePath"
  class_name = "configRsRemotePath"
  content = {
    tnFileRemotePathName = var.remote_location
  }
}

resource "aci_rest" "configRsExportScheduler" {
  dn         = "${aci_rest.configExportP.dn}/rsExportScheduler"
  class_name = "configRsExportScheduler"
  content = {
    tnTrigSchedPName = var.scheduler
  }
}
