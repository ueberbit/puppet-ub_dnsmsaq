class ub-dnsmasq {
  $ip = '192.168.33.2'
  $executable = '/opt/boxen/repo/shared/ub-dnsmasq/files/loopback.sh'

  class { 'dnsmasq::config':
    address => $ip,
  }

  class { 'dnsmasq':
    require => Class['dnsmasq::config'],
  }

  file { '/Library/LaunchDaemons/dev.ub-dnsmasq.loopback.plist':
    content => template('ub-dnsmasq/dev.ub-dnsmasq.loopback.plist.erb'),
    group   => 'wheel',
    notify  => Service['dev.ub-dnsmasq.loopback'],
    owner   => 'root'
  }

  service { 'dev.ub-dnsmasq.loopback':
    ensure  => running,
    require => Package['boxen/brews/dnsmasq']
  }
}
