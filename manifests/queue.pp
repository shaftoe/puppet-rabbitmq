
define rabbitmq::queue {

  $params = "-u $rabbitmq::user -p $rabbitmq::pass declare queue name=$title durable=true"
  exec { "create-${title}-queue":
    command     => "/usr/sbin/rabbitmqadmin $params",
    refreshonly => true,
    subscribe   => Exec['restart-rabbitmq'],
    require     => [
        Class['rabbitmq::installer'],
        Package['python'],
    ]
  }

}
