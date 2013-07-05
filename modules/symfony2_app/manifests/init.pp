class symfony2_app
{

	package { 'git-core':
    	ensure => present,
    }

   	exec { 'install composer':
	    command => 'curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin',
	    require => Package['php5-cli'],
	}

	exec { 'global composer':
		command => "sudo mv /usr/local/bin/composer.phar /usr/local/bin/composer",
		require => Exec['install composer'],
	}

	exec { 'create project folder':
		command => "/bin/sh -c mkdir /var/www/jhk2.local",
		require => Exec['install composer'],
	}
	
	exec { 'clone project':
		command => "/bin/sh -c 'cd /var/www/jhk2.local && git clone https://github.com/yoelkj/demo-symfony2.git'",
		require => [Exec['install composer'], Exec['create project folder']],
	}

	exec { 'get symfony packages':
		command => "/bin/sh -c 'cd /var/www/ && composer update'",
		require => [Exec['global composer'], Package['git-core'], Exec['clone project']],
		creates => "/var/www/composer.lock",
		timeout => 900,
	}

	exec { 'remove optimized class loader':
		command => "/bin/sh -c 'rm /var/www/bootstrap/compiled.php'",
		onlyif => "[ -f /var/www/bootstrap/compiled.php ]"
	}

	exec { 'get symfony updates':
        command => "/bin/sh -c 'cd /var/www/ && composer update'",
        require => [Exec['get symfony packages'], Exec['remove optimized class loader'], Package['git-core']],
        timeout => 900,
	}


	file { '/var/www/':
		mode => 0777
	}
}
