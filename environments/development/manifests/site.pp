node default {
    $mailhost = hiera('mailhost')
    include linux_accts::bash
    class {'puppet': puppetserver => 'VPNA-DEV-MSC501.ad-dev.issgovernance.com', }
    class { 'mcollective': client => false, server => true, }
    include snmpd
    include rsyslog
}

node 'VPNA-DEV-NWK201.AD-DEV.issgovernance.com' inherits default {
    include postfix
    class {'postfix::reports': postfix_summary_email => 'james.bishop@issgovernance.com', }
}

node 'vpna-dev-msc501.ad-dev.issgovernance.com' {
    $mailhost = hiera('mailhost')
    $puppetserver = hiera('mcollective::host')
    include puppet::server
    class { 'mcollective': client => true, server => true, }
    include sendmail
    include snmpd
    include rsyslog
}

node /^vpna\-dev\-tmc\d+\.ad\-\.issgovernance\.com$/ inherits default {
    include sendmail
}

node /^vpna\-dev\-php\d+\.ad\-\.issgovernance\.com$/ inherits default {
    include sendmail
}

node /^vpna\-dev\-msc\d+\.ad\-\.issgovernance\.com$/ inherits default {
    include sendmail
}

node /^VPNA\-DEV\-DBX\d+\.ad\-\.issgovernance\.com$/ inherits default {
    include sendmail
}

node /^VPNA\-DEV\-DBO\d+\.ad\-\.issgovernance\.com$/ inherits default {
    include sendmail
}

