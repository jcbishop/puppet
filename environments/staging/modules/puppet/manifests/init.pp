class puppet (
	$puppetserver = 'servername',
){

	file { "/etc/puppet/puppet.conf":
		ensure  => file,
        	source  => "puppet:///modules/puppet/puppet.conf",
		mode    => 0644,
        	owner   => 'root',
        	group   => 'root'
	}

}

