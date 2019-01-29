# filebeat::service
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include filebeat::service
class filebeat::service (
  $ensure          = $::filebeat::ensure,
  $service_ensure  = $::filebeat::service_ensure,
  $validate_cmd    = $::filebeat::validate_cmd,
  $validate_config = $::filebeat::validate_config,
){

  if $ensure == 'present' or $ensure =~ /6.*/ {
    case $service_ensure {
      'enabled': {
        $_service_ensure = 'running'
        $service_enable = true
      }
      'disabled': {
        $_service_ensure = 'stopped'
        $service_enable = false
      }
      'running': {
        $_service_ensure = 'running'
        $service_enable = false
      }
      default: {
      }
    }
  } else {
    $_service_ensure = 'stopped'
    $service_enable = false
  }

  if $validate_config {
    service { 'filebeat':
      ensure  => $_service_ensure,
      enable  => $service_enable,
      require => Exec[$validate_cmd],
    }
  } else {
    service { 'filebeat':
      ensure => $_service_ensure,
      enable => $service_enable,
    }
  }

  exec { $validate_cmd:
    refreshonly => true,
  }
}
