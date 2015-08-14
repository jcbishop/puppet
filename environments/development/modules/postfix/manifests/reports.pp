class postfix::reports (
    $postfix_summary_email = 'james.bishop@issgovernance.com',
) {
    file { 'pflogsumm':
        path   => '/usr/local/bin/pflogsumm.pl',
        source => "puppet:///modules/postfix/pflogsumm.pl",
        mode   => '0755',
        owner  => 'root',
        group  => 'root',
        ensure => 'present'
    }
    
    file { 'pflogsumm.1':
        path    => '/usr/local/man/man1/pflogsumm.1',
        source  => 'puppet:///modules/postfix/pflogsumm.1',
        mode    => '0644',
        owner   => 'bin',
        group   => 'bin',
        ensure  => 'present',
        require => File['man1']
    }
    
    file {'man1':
        path   => '/usr/local/man/man1',
        ensure => 'directory',
        mode   => '0755',
        owner  => 'root',
        group  => 'root'
    }
    
    file {'/etc/logrotate.d/postfix':
        content => template('postfix/logrotate.erb'),
        mode    => '0755',
        owner   => 'root',
        group   => 'root',
        ensure  => 'present',
        require => File['pflogsumm']
    }

}
