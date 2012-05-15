
class rabbitmq::postinstall () {

    exec { 'stop-rabbitmq-server':
        refreshonly => true,
        command     => '/etc/init.d/rabbitmq-server stop',
        notify      => Exec['stop-epmd'],
        subscribe   => Class['rabbitmq::installer']
    }

    exec { 'stop-epmd':
        refreshonly => true,
        command     => '/usr/bin/killall epmd',
    }

    # Do not start on boot
    service { 'rabbitmq-server':
        hasstatus => false,
        enable    => false,
        require   => Class['rabbitmq::installer'],
    }

}
