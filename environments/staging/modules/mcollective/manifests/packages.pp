class mcollective::packages inherits mcollective {

    package { 'mcollective-common':  ensure => 'present', }
    package { 'mcollective-package-common':  ensure => 'present', }
    package { 'mcollective-facter-facts':  ensure => 'present', }
    package { 'mcollective-puppet-common':  ensure => 'present', }
    package { 'mcollective-package-agent':  ensure => 'present', }
    package { 'mcollective-service-agent':  ensure => 'present', }
    package { 'mcollective-sysctl-data':  ensure => 'present', }
    package { 'mcollective-service-common':  ensure => 'present', }
    package { 'mcollective-puppet-agent':  ensure => 'present', }
}
