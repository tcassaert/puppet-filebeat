# filebeat::config
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include filebeat::config
class filebeat::config (
  $config_dir           = $::filebeat::config_dir,
  $config_reload        = $::filebeat::config_reload,
  $elasticsearch_hosts  = $::filebeat::elasticsearch::hosts,
  $inputs               = $::filebeat::inputs,
  $inputs_location      = $::filebeat::inputs_location,
  $home_path            = $::filebeat::home_path,
  $logstash_hosts       = $::filebeat::logstash_hosts,
  $logstash_loadbalance = $::filebeat::logstash_loadbalance,
  $modules_location     = $::filebeat::modules_location,
  $shipper_name         = $::filebeat::shipper_name,
){

  file { $home_path:
    ensure  => 'directory',
    require => Package['filebeat'],
  }

  file { "${config_dir}/filebeat.yml":
    ensure  => 'present',
    content => template('filebeat/filebeat.yml.erb'),
    notify  => Service['filebeat'],
    require => Package['filebeat'],
  }
}
