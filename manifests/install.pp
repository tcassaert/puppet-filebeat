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
){
  if $manage_repo {
    $major_version = $ensure ? {
      /^6/    => '6',
      /^7/    => '7',
      default => '6',
    }

    case $::osfamily {
      'Debian': {
        Class['apt::update'] -> Package['filebeat']

        if !defined(Apt::Source['elastic']){
          apt::source { 'elastic':
            ensure   => 'present',
            location => "https://artifacts.elastic.co/packages/${major_version}.x/apt",
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
            baseurl  => "https://artifacts.elastic.co/packages/${major_version}.x/yum",
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
