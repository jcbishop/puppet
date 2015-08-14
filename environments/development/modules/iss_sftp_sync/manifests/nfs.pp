class iss_sftp_accounts::nfs_export {
    file_line {'sftp_export':
        path => '/etc/exports',
        line => '/opt/sftpadmin vpna-prd-ftp001(rw,sync,no_root_squash) vpna-prd-ftp002(rw,sync,no_root_squash) vpna-prd-ftp003(rw,sync,no_root_squash) vpna-prd-ftp004(rw,sync,no_root_squash)',
    }

}

class iss_sftp_accounts::nfs_mount {
    file_line {'sftp_mount':
	path => '/etc/fstab',
	line => 'vpna-prd-fsl501.ad.issgovernance.com:/opt/sftpadmin /opt/sftpadmin nfs soft,intr,rsize=8192,wsize=8192,nosuid,tcp 0 0',
	notify => Service['nfs'],
    }

}
