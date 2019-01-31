# filebeat::inputs
#
# A description of what this defined type does
#
# @summary A short summary of the purpose of this defined type.
#
# @example
#   filebeat::inputs { 'namevar': }
define filebeat::inputs(
  String $input_type,
  String $inputs_location = $::filebeat::inputs_location,
  Hash   $config          = {},
) {

  if ! defined(Class['filebeat']) {
      fail('You must include the filebeat base class before using any filebeat defined resources')
  }

  file { "${inputs_location}/${title}.yml":
    ensure  => 'present',
    content => template("${module_name}/inputs.yml.erb"),
    mode    => '0644',
    notify  => Service['filebeat'],
    require => Package['filebeat'],
  }
}
