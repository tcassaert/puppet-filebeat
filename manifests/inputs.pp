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
  String $filebeat_inputs_dir = '/etc/filebeat/inputs.d',
  Hash   $config              = {},
) {

  if ! defined(Class['filebeat']) {
      fail('You must include the filebeat base class before using any filebeat defined resources')
  }

  if ! defined(File[$filebeat_inputs_dir]) {
    file { $filebeat_inputs_dir:
      ensure => 'directory',
    }
  }

  file { "${filebeat_inputs_dir}/${title}.yml":
    ensure  => 'present',
    content => template("${module_name}/inputs.yml.erb"),
    mode    => '0644',
    notify  => Service['filebeat'],
  }
}
