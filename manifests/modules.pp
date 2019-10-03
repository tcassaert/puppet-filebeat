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
  Boolean                   $apache_access_enabled = true,
  Array[String]             $apache_access_paths   = [],
  Optional[Hash]            $apache_config_hash    = undef,
  Boolean                   $apache_error_enabled  = true,
  Array[String]             $apache_error_paths    = [],

  # Nginx module variables
  Boolean                   $nginx_access_enabled   = true,
  Array[String]             $nginx_access_paths     = [],
  Optional[Hash]            $nginx_config_hash      = undef,
  Boolean                   $nginx_error_enabled    = true,
  Array[String]             $nginx_error_paths      = [],
) {

  include ::filebeat

  if ( $::filebeat::ensure =~ /^6/ ) {
    if ($module == 'apache2') {
      $_module = 'apache'
    } else {
      $_module = $module
    }
  } else {
    $_module = $module
  }

  if $enabled {
    file { "${filebeat_module_dir}/${module}.yml":
      ensure  => 'present',
      content => template("${module_name}/modules/${_module}.yml.erb"),
      mode    => '0644',
      notify  => Service['filebeat'],
      require => Package['filebeat'],
    }

  } else {
    file { "${filebeat_module_dir}/${module}.yml":
      ensure  => 'absent',
      notify  => Service['filebeat'],
      require => Package['filebeat'],
    }
  }
}
