# filebeat
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include filebeat
class filebeat (
  Optional[Array[Hash]]                      $autodiscovery        = undef,
  String                                     $config_dir           = $config_dir,
  Boolean                                    $config_reload        = $config_reload,
  Optional[Array[String]]                    $elasticsearch_hosts  = undef,
  Variant[String, Enum['present', 'absent']] $ensure               = $ensure,
  Optional[String]                           $inputs_location      = $inputs_location,
  Optional[Boolean]                          $inputs_purge         = $inputs_purge,
  String                                     $home_path            = $home_path,
  Optional[Array[String]]                    $logstash_hosts       = undef,
  Boolean                                    $logstash_loadbalance = $logstash_loadbalance,
  Optional[String]                           $logstash_ttl         = undef,
  Optional[Integer]                          $logstash_pipelining  = undef,
  Boolean                                    $manage_repo          = $manage_repo,
  Optional[String]                           $modules_location     = $modules_location,
  Enum['enabled', 'disabled', 'running']     $service_ensure       = $service_ensure,
  String                                     $shipper_name         = $shipper_name,
  Boolean                                    $validate_config      = $validate_config,
  String                                     $validate_cmd         = $validate_cmd,
){

  class { '::filebeat::install': }
  -> class { '::filebeat::config': }
  -> class { '::filebeat::service': }
}
