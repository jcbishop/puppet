class sendmail {
    package {'sendmail-cf': ensure => 'present', }

    file {'/etc/mail/sendmail.mc':
        mode => 0644,
        owner => 'root',
        group => 'root',
        content => template('sendmail/sendmail.mc.erb'),
        require => Package["sendmail-cf"],
    }

    exec { "make_sendmail_config" :
        command => '/usr/bin/make -C /etc/mail',
        cwd => '/etc/mail',
        refreshonly => true,
        subscribe => File["/etc/mail/sendmail.mc"]
    }

    service { "sendmail" :
        ensure => true,
        enable => true,
        subscribe => Exec["make_sendmail_config"],
    }

}
        
