
define rabbitmq::queue (
    $user,
    $pass
  ) {

  $params = "-u $user -p $pass declare queue name=$title durable=true"
  exec { "create-${title}-queue":
    command     => "/usr/sbin/rabbitmqadmin $params",
    refreshonly => true,
    subscribe   => Exec['restart-rabbitmq'],
  }

}
