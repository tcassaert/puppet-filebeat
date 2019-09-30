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
    case $::osfamily {
      'Debian': {
        Class['apt::update'] -> Package['filebeat']

        if !defined(Apt::Source['elastic']){
          apt::source { 'elastic':
            ensure   => 'present',
            location => $repo_url,
            release  => 'stable',
            repos    => 'main',
            key      => {
              id     => '46095ACC8548582C1A2699A9D27D666CD88E42B4',
              source => 'https://artifacts.elastic.co/GPG-KEY-elasticsearch',
            },
          }
        }

        package { 'filebeat':
          ensure  => $ensure,
          require => Apt::Source['elastic'],
          notify  => Service['filebeat'],
        }
      }
      'RedHat': {
        if !defined(Yumrepo['elastic']) {
          yumrepo { 'elastic':
            descr    => 'Repository for Elastic rpms',
            enabled  => 1,
            baseurl  => $repo_url,
            gpgcheck => '1',
            gpgkey   => 'https://artifacts.elastic.co/GPG-KEY-elasticsearch',
          }
        }

        package { 'filebeat':
          ensure  => $ensure,
          require => Yumrepo['elastic'],
          notify  => Service['filebeat'],
        }
      }
    }
  }
  else {
    package { 'filebeat':
      ensure => $ensure,
      notify => Service['filebeat'],
    }
  }
}
