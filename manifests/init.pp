class adminer (
    String              $adminer_url        = 'https://www.adminer.org/latest.php',
    String              $install_dir        = $::adminer::params::install_dir,
    String              $apache_conf_dir    = $::adminer::params::apache_config_dir,
    Array[ String ]     $allow_list         = [ '127.0.0.1' ],
    ) {
    
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
    
}