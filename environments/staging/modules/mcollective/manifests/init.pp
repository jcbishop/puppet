class mcollective (
    $port        	= hiera('mcollective_port'),
    $broker_ssl_ca      = 'UNSET',
    $broker_ssl_cert    = 'UNSET',
    $broker_ssl_key     = 'UNSET',
    $user        	= hiera('mcollective::user'),
    $client		= false,
    $client_config_file = 'client.cfg',
    $configdir		= '/etc/mcollective',
    $log_level		= 'info',
    $security_provider	= 'psk',
    $security_secret	= hiera('mcollective::plugin_psk'),
    $server		= true,
    $server_config_file = 'server.cfg',
    $version		= 'UNSET',
    $host      = hiera('mcollective::host'),
    $ssl       = hiera('mcollective::ssl'),
    $passwd    = hiera('mcollective::password'),
    $log_level        = hiera('mcollective::log_level'),
    $main_collective  = hiera('mcollective::main_collective'),
    $sub_collectives  = hiera('mcollective::sub_collectives'),
) {
    require mcollective::packages

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

	file{"/etc/mcollective/facts.yaml":
      	    owner    => root,
      	    group    => root,
      	    mode     => 400,
      	    loglevel => debug, # reduce noise in Puppet reports
      	    content  => inline_template("<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime_seconds|timestamp|free)/ }.to_yaml %>"), # exclude rapidly changing facts
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
    file { [ '/etc/mcollective/plugin.d/get_passwd_cksum.cfg' ]:
        ensure  => present, 
        mode    => 0644,
        owner   => 'root',
        group   => 'root',
        content => 'activate_agent = true',
    }
}
