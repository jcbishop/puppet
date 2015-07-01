node default {
    $mailhost = hiera('mailhost')
    include linux_accts::bash
    class {'puppet': puppetserver => 'VSNA-UAT-MSC501.ad.issgovernance.com', }
    class { 'mcollective': client => false, server => true,}
    include snmpd
}

node 'VSNA-UAT-NWK201.AD.issgovernance.com' inherits default {
	include postfix
	class {'postfix::reports': postfix_summary_email => 'james.bishop@issgovernance.com', }
}

node 'vsna-uat-msc501.ad.issgovernance.com' {
   $mailhost = hiera('mailhost')
   $puppetserver = hiera('mcollective::host')
   include puppet::server
   class { 'mcollective': client => 'true', server => 'true', }
   include sendmail
   include snmpd
}

node /^vsna\-uat\-php\d+\.ad\.issgovernance\.com$/ inherits default {
    include sendmail

}

node /^vsna\-uat\-tmc\d+\.ad\.issgovernance\.com$/ inherits default {
    include sendmail
    inlude snmpd
}

node /^vsna\-uat\-dbx\d+\.ad\.issgovernance\.com$/ inherits default {
    include sendmail
    include snmpd
}

node /^vsna\-uat\-ftp\d+\.ad\.issgovernance\.com$/ inherits default {
    include sendmail
    include snmpd
    include proftpd
}
