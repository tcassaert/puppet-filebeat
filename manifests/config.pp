# filebeat::config
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include filebeat::config
class filebeat::config (
  $autodiscovery            = $::filebeat::autodiscovery,
  $config_dir               = $::filebeat::config_dir,
  $config_reload            = $::filebeat::config_reload,
  $elasticsearch_hosts      = $::filebeat::elasticsearch_hosts,
  $ensure                   = $::filebeat::ensure,
  $inputs_location          = $::filebeat::inputs_location,
  $inputs_purge             = $::filebeat::inputs_purge,
  $home_path                = $::filebeat::home_path,
  $log_path                 = $::filebeat::log_path,
  $logstash_hosts           = $::filebeat::logstash_hosts,
  $logstash_loadbalance     = $::filebeat::logstash_loadbalance,
  $logstash_ttl             = $::filebeat::logstash_ttl,
  $logstash_pipelining      = $::filebeat::logstash_pipelining,
  $modules_location         = $::filebeat::modules_location,
  $shipper_name             = $::filebeat::shipper_name,
){

  file { $home_path:
    ensure  => 'directory',
    require => Package['filebeat'],
  }

  file { $log_path:
    ensure  => 'directory',
    require => Package['filebeat'],
  }

  file { "${config_dir}/filebeat.yml":
    ensure  => 'present',
    content => template('filebeat/filebeat.yml.erb'),
    notify  => Service['filebeat'],
    require => Package['filebeat'],
  }

  file { $inputs_location:
    ensure  => 'directory',
    purge   => $inputs_purge,
    recurse => true,
    require => Package['filebeat'],
    notify  => Service['filebeat'],
  }
}
