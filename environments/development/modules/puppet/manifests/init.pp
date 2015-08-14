class puppet (
	$puppetserver = 'servername',
){

	file { "/etc/puppet/puppet.conf":
		ensure  => file,
        	content  => template("puppet/puppet.conf.erb"),
		mode    => 0644,
        	owner   => 'root',
        	group   => 'root'
	}

}

