class rabbitmq::installer (
        $user,
        $pass,
        $major,
        $minor
    ) {

    require 'rabbitmq::config'

    $version      = "${major}-${minor}"
    $base_url     = 'http://www.rabbitmq.com/releases/rabbitmq-server'
    $package_name = "rabbitmq-server_${version}_all.deb"
    $package_url  = "${base_url}/v${major}/${package_name}"


    # Create group/user
    group { 'rabbitmq':
        ensure      => present,
    }

    user { 'rabbitmq':
        ensure      => present,
        gid         => 'rabbitmq',
        shell       => '/bin/false',
        home        => '/var/lib/rabbitmq',
        require     => Group['rabbitmq'],
    }

    # Install
    rabbitmq::dpkg_install { 'rabbitmq-server':
        url         => $package_url,
        version     => $version,
    }


    # Rabbitmq users
    rabbitmq::user { 'guest':
        action  => 'delete',
    }
    rabbitmq::user { $user:
        action  => 'create',
        pass    => $pass,
    }

    exec { 'enable-rabbit-plugins':
        refreshonly => true,
        command     => '/usr/sbin/rabbitmq-plugins enable rabbitmq_management',
        subscribe   => Rabbitmq::Dpkg_install['rabbitmq-server'],
        notify      => Exec['restart-rabbitmq'],
    }

    # Needed to activate rabbit plugins
    exec { 'restart-rabbitmq':
        refreshonly => true,
        command     => '/etc/init.d/rabbitmq-server restart',
    }

}
