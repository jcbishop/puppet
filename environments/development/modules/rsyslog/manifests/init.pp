class rsyslog {
    file { 'rsyslog.conf':
	    path    => '/etc/rsyslog.conf',
	    source  => "puppet:///modules/rsyslog/rsyslog.conf",
	    owner   => 'root',
	    group   => 'root',
	    mode    => '0644',
	    notify  => Service['rsyslog'],
	    require => Package['rsyslog']
    }

    package { 'rsyslog':
	    ensure => 'present',
    }

    service {'rsyslog':
	    ensure    => 'running',
	    enable    => true,
	    subscribe => File['rsyslog.conf']
    }
}

