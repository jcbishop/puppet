class automounts {

        package { 'autofs':  ensure => 'present', }

        file {'/etc/auto.master':
                mode  => 0644,
                owner => 'root',
                group => 'root',
                source => "puppet:///modules/automounts/auto.master",
                replace => false,
                require => Package['autofs']
        }
        file {'/etc/auto.home':
                mode  => 0644,
                owner => 'root',
                group => 'root',
                source => "puppet:///modules/automounts/auto.home",
                replace => false,
                require => File['/etc/auto.master']
        }
        file {'/etc/auto.misc':
                mode  => 0644,
                owner => 'root',
                group => 'root',
                source => "puppet:///modules/automounts/auto.misc",
                replace => false,
                require => File['/etc/auto.home']
        }

        service {'autofs':
                ensure => true,
                enable => true,
                subscribe => File['/etc/auto.misc'],
        }

}
