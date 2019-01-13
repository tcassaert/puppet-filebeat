# filebeat
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include filebeat
class filebeat (
  String                                     $config_dir          = $config_dir,
  Boolean                                    $config_reload       = $config_reload,
  Optional[Array[String]]                    $elasticsearch_hosts = undef,
  Variant[String, Enum['present', 'absent']] $ensure              = $ensure,
  Optional[String]                           $inputs_location     = undef,
  String                                     $home_path           = $home_path,
  Optional[Array[String]]                    $logstash_hosts      = undef,
  Boolean                                    $manage_repo         = $manage_repo,
  Optional[String]                           $modules_location    = undef,
  String                                     $repo_url            = $repo_url,
  Enum['enabled', 'disabled', 'running']     $service_ensure      = $service_ensure,
  String                                     $shipper_name        = $shipper_name,
  Boolean                                    $validate_config     = $validate_config,
  String                                     $validate_cmd        = $validate_cmd,
){

  class { '::filebeat::install': }
  -> class { '::filebeat::config': }
  -> class { '::filebeat::service': }
}
