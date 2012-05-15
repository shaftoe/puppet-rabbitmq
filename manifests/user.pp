
define rabbitmq::user (
    $action,
    $administrator = false,
    $pass = false
  ) {

    case $action {

    # create user by default
    default: {
      exec { "create-${title}-user":
        refreshonly => true,
        command     => "/usr/sbin/rabbitmqctl add_user '${title}' '${pass}'",
        notify      => Exec["grant-${title}-user"],
        subscribe   => Exec['restart-rabbitmq'],
      }
      exec { "grant-${title}-user":
        refreshonly => true,
        command     => "/usr/sbin/rabbitmqctl set_permissions $title '.*' '.*' '.*'",
      }

      if $administrator {
        exec { "set-${title}-tag":
            refreshonly => true,
            subscribe   => Exec['restart-rabbitmq'],
            command     => "/usr/sbin/rabbitmqctl set_user_tags ${title} administrator",
        }
      }
    }

    'delete': {
      exec { "delete-${title}-user":
        refreshonly => true,
        command     => "/usr/sbin/rabbitmqctl delete_user $title",
        subscribe   => Exec['restart-rabbitmq'],
      }
    }
  }
}
