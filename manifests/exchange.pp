
define rabbitmq::exchange (
        $user,
        $pass,
        $key,
        $queue
    ) {

    $c_params = "-u $user -p $pass declare exchange name=$title type=direct durable=true"
    exec { "create-${title}-exchange":
        command     => "/usr/sbin/rabbitmqadmin $c_params",
        refreshonly => true,
        subscribe   => Exec['restart-rabbitmq'],
    }

    $r_params = "-u $user -p $pass publish routing_key=$key exchange=$title"
    exec { "create-${title}-routingkey":
        command     => "/usr/sbin/rabbitmqadmin $r_params",
        refreshonly => true,
        subscribe   => Exec["create-${title}-exchange"],
    }

    $b_params = "-u $user -p $pass declare binding source=$title destination_type=queue destination=$queue routing_key=$key"
    exec { "create-${title}-binding":
        command     => "/usr/sbin/rabbitmqadmin $b_params",
        refreshonly => true,
        subscribe   => Exec["create-${title}-routingkey"],
    }

}
