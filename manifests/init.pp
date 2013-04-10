class ub_dnsmasq {
  $ip = '192.168.33.1'
  $executable = '/opt/boxen/repo/shared/ub_dnsmasq/files/loopback.sh'

  class { 'dnsmasq::config':
    configfile_source => 'puppet:///modules/ub_dnsmasq/dnsmasq.conf'
  }

  class { 'dnsmasq':
    require => Class['dnsmasq::config'],
  }

  file { '/Library/LaunchDaemons/dev.ub_dnsmasq.loopback.plist':
    content => template('ub_dnsmasq/dev.ub_dnsmasq.loopback.plist.erb'),
    group   => 'wheel',
    notify  => Service['dev.ub_dnsmasq.loopback'],
    owner   => 'root'
  }

  service { 'dev.ub_dnsmasq.loopback':
    ensure  => running,
    require => Package['boxen/brews/dnsmasq']
  }
}
