class postfix (
    $smtp_server = hiera('smtp_server'),
    $mydomain = hiera('mydomain'),
    $relay_host = hiera('relay_host'),
    $message_size_limit = hiera('message_size_limit'),
    $allowed_subnet = hiera('allowed_subnet'),
    $recipient_domains = hiera('recipient_domains')
){
    package {'postfix': ensure => present,}
    
    file { "main.cf":
	    path    => "/etc/postfix/main.cf",
	    owner   => 'root',
	    group   => 'sysadmin',
	    mode    => '0644',
	    require => Package['postfix'],
	    content => template('postfix/main.cf.erb')
    }

    file { "master.cf":
	    path    => "/etc/postfix/master.cf",
	    owner   => 'root',
	    group   => 'sysadmin',
	    mode    => '0644',
	    require => Package['postfix'],
	    content => template('postfix/master.cf.erb')
    }

    file { 'port_25':
	    path   => "/etc/postfix/port_25",
	    ensure => 'directory',
	    owner  => 'root',
	    group  => 'sysadmin',
	    mode   => '0755'
    }

    file { "mynetworks":
	    path    => "/etc/postfix/port_25/mynetworks",
	    owner   => 'root',
	    group   => 'sysadmin',
	    mode    => '0644',
	    content => template('postfix/mynetworks.erb'),
	    require => File['port_25'],
	    notify  => Exec['postmap-mynetworks']
    }

    exec { 'postmap-mynetworks':
	    cwd         => '/etc/postfix/port_25',
	    path        => '/bin:/usr/bin:/sbin:/usr/sbin',
	    command     => 'postmap mynetworks',
	    refreshonly => true,
	    notify      => Service['postfix']
    }

    file { "check_recipient_access.regexp":
	    path    => "/etc/postfix/port_25/check_recipient_access.regexp",
	    owner   => 'root',
	    group   => 'sysadmin',
	    mode    => '0644',
	    content => template('postfix/check_recipient_access.regexp.erb'),
	    require => File['port_25'],
	    notify  => Exec['postmap-recipient_access']
    }

    exec { 'postmap-recipient_access':
	    cwd         => '/etc/postfix/port_25',
	    path        => '/bin:/usr/bin:/sbin:/usr/sbin',
	    command     => 'postmap check_recipient_access.regexp',
	    refreshonly => true,
	    notify      => Service['postfix']
    }

    file { 'check_sender_access':
	    path    => "/etc/postfix/port_25/check_sender_access",
	    owner   => 'root',
	    group   => 'sysadmin',
	    mode    => '0644',
	    content => template('postfix/check_sender_access.erb'),
	    require => File['port_25'],
	    notify  => Exec['postmap-sender_access']
    }

    exec { 'postmap-sender_access':
	    cwd         => '/etc/postfix/port_25',
	    path        => '/bin:/usr/bin:/sbin:/usr/sbin',
	    command     => 'postmap check_sender_access',
	    refreshonly => true,
	    notify      => Service['postfix']
    }

    service { 'postfix':
	    ensure => running,
	    enable => true,
    }
    
    
}
