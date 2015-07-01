filebucket { 'main':
    path   => false,
    server => 'vpna-cor-msc502.ad.issgovernance.com'
}

File { backup => main, }

node default {

	include puppet
	class { 'mcollective': client => 'false', server => 'true', }
}
