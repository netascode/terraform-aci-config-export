terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

module "main" {
  source = "../.."

  name            = "EXP1"
  description     = "My Description"
  format          = "xml"
  remote_location = "REMOTE1"
  scheduler       = "SCHEDULER1"
}

data "aci_rest" "configExportP" {
  dn = "uni/fabric/configexp-${module.main.name}"

  depends_on = [module.main]
}

resource "test_assertions" "configExportP" {
  component = "configExportP"

  equal "name" {
    description = "name"
    got         = data.aci_rest.configExportP.content.name
    want        = module.main.name
  }

  equal "descr" {
    description = "descr"
    got         = data.aci_rest.configExportP.content.descr
    want        = "My Description"
  }

  equal "format" {
    description = "format"
    got         = data.aci_rest.configExportP.content.format
    want        = "xml"
  }
}

data "aci_rest" "configRsRemotePath" {
  dn = "${data.aci_rest.configExportP.id}/rsRemotePath"

  depends_on = [module.main]
}

resource "test_assertions" "configRsRemotePath" {
  component = "configRsRemotePath"

  equal "tnFileRemotePathName" {
    description = "tnFileRemotePathName"
    got         = data.aci_rest.configRsRemotePath.content.tnFileRemotePathName
    want        = "REMOTE1"
  }
}

data "aci_rest" "configRsExportScheduler" {
  dn = "${data.aci_rest.configExportP.id}/rsExportScheduler"

  depends_on = [module.main]
}

resource "test_assertions" "configRsExportScheduler" {
  component = "configRsExportScheduler"

  equal "tnTrigSchedPName" {
    description = "tnTrigSchedPName"
    got         = data.aci_rest.configRsExportScheduler.content.tnTrigSchedPName
    want        = "SCHEDULER1"
  }
}
