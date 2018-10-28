class adminer (
    String              $adminer_url                = 'https://www.adminer.org/latest.php',
    String              $install_dir                = $::adminer::params::install_dir,
    String              $apache_default_config      = $::adminer::params::apache_default_config,
    String              $apache_name                = $::adminer::params::apache_name,
    Array[ String ]     $allow_from                 = [ '127.0.0.1' ],
    String              $apache_alias               = 'adminer',
    ) inherits ::adminer::params {
    
    include wget
    
    file { $install_dir:
        ensure          => 'directory',
    }
    
    wget::fetch { "Downloading latest adminer from: ${adminer_url}":
        source          => $adminer_url,
        destination     => "${install_dir}/index.php",
        timeout         => 0,
        verbose         => false,
        require         => File[ $install_dir ],
    }
    
    file { $apache_default_config:
        ensure          => present,
        content         => epp('adminer/adminer.conf.epp', {
                                'apache_alias' => $apache_alias,
                                'install_dir'  => $install_dir,
                                'allow_list'   => $allow_from,
                            }
                        ),
        require         => File[ $install_dir ],
        notify          => Service[ $apache_name ],
    }
    
}