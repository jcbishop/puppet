class mcollective (
    $broker_port	= '61613',
    $broker_ssl_ca      = 'UNSET',
    $broker_ssl_cert    = 'UNSET',
    $broker_ssl_key     = 'UNSET',
    $broker_user	= 'mcollective',
    $client		= false,
    $client_config_file = 'client.cfg',
    $configdir		= '/etc/mcollective',
    $log_level		= 'info',
    $main_collective	= 'mcollective',
    $security_provider	= 'psk',
    $security_secret	= 'S3cr3t',
    $server		= true,
    $server_config_file = 'server.cfg',
    $sub_collectives	= 'UNSET',
    $version		= 'UNSET',
) {
    require mcollective::packages


    $broker_host      = hiera ('mcollective::broker_host'),
    $broker_passwd    = hiera ('mcollective_broker_passwd'),
    $broker_ssl       = hiera ('mcollective::broker_ssl'),
    $log_level        = hiera ('mcollective::log_level'),
    $main_collective  = hiera ('mcollective::main_collective'),
    $sub_collectives  = hiera ('mcollective::sub_collectives'),
    $myfact = "<%= scope.to_hash.reject { |k,v| !( k.is_a?(String) && v.is_a?(String) ) }.to_yaml %>"


    if ( $server ) {
      	file { "${configdir}/${server_config_file}":
      	    ensure  => file,
      	    mode    => 0644,
      	    owner   => root,
      	    group   => root,
      	    content => template('mcollective/server.conf.erb'),
      	    require  => Package['mcollective', 'rubygem-stomp'],
      	}
      	package { [ 'mcollective', 'rubygem-stomp']:
      	    ensure  => 'present',
      	    notify  => Service['mcollective'],
      	}	
      	service { 'mcollective':
      	    ensure => running,
      	    enable => true,
      	    require => Package['mcollective'],
      	    subscribe => File["${configdir}/$server_config_file"],
      	}
        file { "/etc/mcollective/facts.yaml":
            ensure  => file,
            content => inline_template("{myfact}"),
            require => Package["mcollective"];
        }
    } 


    if ($client) {
      	file { "${configdir}/${client_config_file}":
      	    ensure  => present,
      	    mode    => 0644,
      	    owner   => 'root',
      	    group   => 'root',
      	    content => template('mcollective/client.conf.erb'),
      	    require  => Package['mcollective-client'],
      	}
      	package { ['mcollective-client' ]:
      	    ensure  => 'present',
      	}
        file { 'mcollective_profile.sh':
            ensure => 'present',
            source => 'puppet:///modules/mcollective/mcollective_profile.sh',
            path   => '/etc/profile.d/mcollective_profile.sh',
            owner  => 'root',
            group  => 'root',
            mode   => 0644,
        }
    }


    file { [ '/usr/libexec/mcollective/mcollective/agent' ]:
        mode    => 0644,
        owner   => 'root',
        group   => 'root',
        source  => "puppet:///modules/mcollective/agent",
	sourceselect => all,
        recurse => true,
        purge   => false,
        replace => true,
    }
    file { [ '/etc/mcollective/plugin.d/checkmailqueue.cfg' ]:
        ensure  => present, 
        mode    => 0644,
        owner   => 'root',
        group   => 'root',
        content => 'activate_agent = true',
    }
    file { [ '/etc/mcollective/plugin.d/checkdiskspace.cfg' ]:
        ensure  => present, 
        mode    => 0644,
        owner   => 'root',
        group   => 'root',
        content => 'activate_agent = true',
    }
}
