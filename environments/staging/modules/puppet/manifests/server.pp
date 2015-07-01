class puppet::server {

	file { "/etc/puppet/puppet.conf":
		ensure  => file,
        	source  => "puppet:///modules/puppet/puppet-server.conf",
		mode    => 0644,
        	owner   => 'root',
        	group   => 'root'
	}

}

