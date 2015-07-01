class { 'nfs':
        package{'nfs-utils': ensure => present,}
        package{'nfs-utils-lib': ensure => present,}
        package{'nfs4-acl-tools': ensure => present,}

        file {'/etc/exports':
                owner => 'root',
                group => 'root',
                mode  => 0644,
                source => File['puppet://modules/sendmail/exports'],
                require => Package['nfs-utils'],
        }
}
