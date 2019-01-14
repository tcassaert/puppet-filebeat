# filebeat::modules
#
# A description of what this defined type does
#
# @summary A short summary of the purpose of this defined type.
#
# @example
#   filebeat::modules { 'namevar': }
define filebeat::modules(
  Enum['enable', 'disable'] $action                 = 'enable',
  String                    $module                 = $title,
  String                    $filebeat_module_dir    = '/etc/filebeat/modules.d',

  # Apache2 module variables
  Boolean                   $apache2_access_enabled = false,
  Array[String]             $apache2_access_paths   = [],
  Optional[Hash]            $apache2_config_hash    = undef,
  Boolean                   $apache2_error_enabled  = false,
  Array[String]             $apache2_error_paths    = [],

  # Nginx module variables
  Boolean                   $nginx_access_enabled   = false,
  Array[String]             $nginx_access_paths     = [],
  Optional[Hash]            $nginx_config_hash      = undef,
  Boolean                   $nginx_error_enabled    = false,
  Array[String]             $nginx_error_paths      = [],
) {

  if ! defined(Class['filebeat']) {
      fail('You must include the filebeat base class before using any filebeat defined resources')
  }

  if $action == 'enable' {
    file { "${filebeat_module_dir}/${module}.yml":
      ensure  => 'present',
      content => template("${module_name}/modules/${module}.yml.erb"),
      mode    => '0644',
      notify  => Service['filebeat'],
    }

  } elsif $action == 'disable' {
    file { "${filebeat_module_dir}/${module}.yml":
      ensure => 'absent',
      notify => Service['filebeat'],
    }
  }
}
