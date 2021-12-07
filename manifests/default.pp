$document_root = '/vagrant'
include apache
include mysql::server
include mysql::client


mysql::db { 'wordpress_db':
  user     => 'wp_user',
  password => 'admin123',
  host     => 'localhost',
  grant    => ['SELECT', 'INSERT', 'UPDATE', 'DELETE'],
}

package { 'php':
  ensure  => 'present',
}

package { 'php-mysql':
  ensure  => 'present',
}

exec { 'get-wordpress-tar':
  cwd     => '/tmp',
  command => '/usr/bin/wget https://wordpress.org/latest.tar.gz',
  creates => '/tmp/latest.tar.gz',
}

file { '/var/www/html/wordpress':
  ensure  => 'directory',
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '755',
}

exec { 'Untar the file':
  command => '/bin/tar -xvf /tmp/latest.tar.gz -C /var/www/html/wordpress',
  # creates => '/var/www/html/wordpress'
  require => File['/var/www/html/wordpress'],
}

file { '/var/www/html/wordpress/wp-content':
  ensure  => 'directory',
}

file { '/var/www/html/wordpress/wp-content/uploads':
  ensure  => 'directory',
  owner   => 'www-data',
  group   => 'www-data',
}

exec { 'Skip Message':
  command => "echo 'Este mensaje solo se muestra si no se ha copiado el fichero index.html'",
  unless  => "test -f ${document_root}/index.html",
  path    => "/bin:/sbin:/usr/bin:/usr/sbin",
}

notify { 'Showing machine Facts':
  message => "Machine with ${::memory['system']['total']} of memory and $::processorcount processor/s. Please check access to http://$::ipaddress_enp0s8}",
}
