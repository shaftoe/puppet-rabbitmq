class rabbitmq (
        $major      = '2.7.1',
        $minor      = '1',
        $user       = 'admin',
        $pass       = 'supersecret'
    ) {

    class { 'rabbitmq::installer':
        user     => $user,
        pass     => $pass,
        major    => $major,
        minor    => $minor
    }

}
