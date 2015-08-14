class linux_accts::bash {
  file {'bash-ps1':
	  owner    => 'root',
	  group    => 'root',
	  mode     => '0755',
	  path     => '/etc/sysconfig/bash-ps1',
	  content => template('linux_accts/bash-ps1.erb'),
  }

  file {'bashrc':
	  owner    => 'root',
	  group    => 'root',
	  mode     => '0644',
	  path     => '/etc/bashrc',
	  content => template('linux_accts/bashrc.erb'),
  }
}
