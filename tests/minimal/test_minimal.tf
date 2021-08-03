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

  name = "EXP1"
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
}
