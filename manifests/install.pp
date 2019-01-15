# filebeat::install
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include filebeat::install
class filebeat::install (
  $ensure      = $::filebeat::ensure,
  $manage_repo = $::filebeat::manage_repo,
  $repo_url    = $::filebeat::repo_url,
){
  if $manage_repo {
    if !defined(Yumrepo['elastic']) {
      yumrepo { 'elastic':
        descr    => 'Repository for Elastic rpms',
        enabled  => 1,
        baseurl  => $repo_url,
        gpgcheck => '1',
        gpgkey   => 'https://artifacts.elastic.co/GPG-KEY-elasticsearch',
      }
    }
  }

  package { 'filebeat':
    ensure  => $ensure,
    require => Yumrepo['elastic'],
  }
}
