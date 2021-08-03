output "dn" {
  value       = aci_rest.configExportP.id
  description = "Distinguished name of `configExportP` object."
}

output "name" {
  value       = aci_rest.configExportP.content.name
  description = "Config export policy name."
}
