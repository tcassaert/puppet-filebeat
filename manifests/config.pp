# filebeat::config
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include filebeat::config
class filebeat::config (
  $config_dir       = $::filebeat::config_dir,
  $config_reload    = $::filebeat::config_reload,
  $inputs           = $::filebeat::inputs,
  $inputs_location  = $::filebeat::inputs_location,
  $home_path        = $::filebeat::home_path,
  $logstash_hosts   = $::filebeat::logstash_hosts,
  $modules_location = $::filebeat::modules_location,
  $shipper_name     = $::filebeat::shipper_name,
){

  file { $home_path:
    ensure => 'directory',
  }

  file { "${config_dir}/filebeat.yml":
    ensure  => 'present',
    content => template('filebeat/filebeat.yml.erb'),
  }
}
