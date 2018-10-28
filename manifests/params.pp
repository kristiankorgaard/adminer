class adminer::params {
    include ::apache::params
    
    $apache_name  = $::apache::params::apache_name
    
    case $::osfamily {
        'RedHat': {
            $install_dir            = '/usr/share/adminer'            
            $apache_config_dir      = $::apache::params::confd_dir
            $apache_default_config  = "${::apache::params::confd_dir}/00-adminer.conf"
        }
        default: {
            fail("Class['adminer::params']: Unsupported OS: ${::osfamily}")
        }
    }    
}