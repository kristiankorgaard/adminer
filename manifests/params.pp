class adminer::params {
    include ::apache::params
    
    case $::osfamily {
        'RedHat': {
            $install_dir            = '/usr/share/adminer'            
            $apache_config_dir      = $::apache::params::confd_dir
        }
        default: {
            fail("Class['adminer::params']: Unsupported OS: ${::osfamily}")
        }
    }    
}