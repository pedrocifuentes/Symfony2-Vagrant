exec { "apt-get update":
  path => "/usr/bin",
}

package { "apache2":
  ensure  => present,
  require => Exec["apt-get update"],
}

package { "php5":
  ensure  => latest,
  require => Exec["apt-get update"],
}

service { "apache2":
  ensure  => "running",
  require => Package["apache2"],
}

file { "/var/www/jhk2.local":
  ensure  => "link",
  target  => "/vagrant/jhk2.local",
  require => Package["apache2"],
  notify  => Service["apache2"],
}
