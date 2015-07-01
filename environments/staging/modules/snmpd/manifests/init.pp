class snmpd {
	package {'net-snmp': ensure => 'present',}
	package {'net-snmp-libs': ensure => 'present',}
	package {'net-snmp-utils': ensure => 'present',}
	package {'php53-snmp': ensure => 'present',}

	file {'snmpd.conf':
		source  => "puppet:///modules/snmpd/snmpd.conf",
		owner   => 'root',
		group   => 'root',
		mode    => '0755',
		path    => '/etc/snmp/snmpd.conf',
		require => Package['net-snmp'],
		notify  => Service['snmpd']
	}

	service {'snmpd':
		ensure    => 'running',
		enable    => true,
		require   => Package['net-snmp'],
		subscribe => File['snmpd.conf']
	}
}
