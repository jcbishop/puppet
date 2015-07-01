class proftpd {
    file {'sync_accounts':
        path	 => '/sbin/sync_accounts',
        owner	 => 'root',
        mode	 => '0750',
        group	 => 'root',
        source	 => 'puppet:///modules/proftpd/sync_accounts',
        ensure	 => 'present',
        require => File['sftpadmin'],
    }

    cron { 'cron_sync':
        command     => '/sbin/sync_accounts 2>&1 >>/var/log/sync_accounts.log &',
        user        => 'root',
        hour        => '*',
        minute      => '*/5',
        ensure      => 'present',
        environment => 'PATH=/sbin:/usr/sbin:/bin:/usr/bin',
        require    => File['sync_accounts'],
    }

    file {'sftpadmin':
        path   => '/shares/comp/sftpadmin',
        ensure => 'directory',
        mode   => '0750',
        owner  => 'root',
        group  => 'root',
    }

    file {'ftp-useradd':
        path   => '/opt/app/proftpd/usr/bin/ftp-useradd',
        ensure => 'exists',
        mode   => '0750',
        owner  => 'root',
        group  => 'root',
    }

}
