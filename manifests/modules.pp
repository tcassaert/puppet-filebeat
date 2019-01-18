# filebeat::modules
#
# A description of what this defined type does
#
# @summary A short summary of the purpose of this defined type.
#
# @example
#   filebeat::modules { 'namevar': }
define filebeat::modules(
  Boolean                   $enabled                = true,
  String                    $filebeat_module_dir    = '/etc/filebeat/modules.d',
  String                    $module                 = $title,

  # Apache2 module variables
  Boolean                   $apache2_access_enabled = true,
  Array[String]             $apache2_access_paths   = [],
  Optional[Hash]            $apache2_config_hash    = undef,
  Boolean                   $apache2_error_enabled  = true,
  Array[String]             $apache2_error_paths    = [],

  # Nginx module variables
  Boolean                   $nginx_access_enabled   = true,
  Array[String]             $nginx_access_paths     = [],
  Optional[Hash]            $nginx_config_hash      = undef,
  Boolean                   $nginx_error_enabled    = true,
  Array[String]             $nginx_error_paths      = [],
) {

  if ! defined(Class['filebeat']) {
      fail('You must include the filebeat base class before using any filebeat defined resources')
  }

  if $enabled {
    file { "${filebeat_module_dir}/${module}.yml":
      ensure  => 'present',
      content => template("${module_name}/modules/${module}.yml.erb"),
      mode    => '0644',
      notify  => Service['filebeat'],
    }

  } else {
    file { "${filebeat_module_dir}/${module}.yml":
      ensure => 'absent',
      notify => Service['filebeat'],
    }
  }
}
