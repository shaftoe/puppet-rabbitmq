class rabbitmq::config {

    $dependencies = [
        'erlang-asn1',
        'erlang-base',
        'erlang-corba',
        'erlang-crypto',
        'erlang-docbuilder',
        'erlang-edoc',
        'erlang-eunit',
        'erlang-ic',
        'erlang-inets',
        'erlang-inviso',
        'erlang-mnesia',
        'erlang-nox',
        'erlang-odbc',
        'erlang-os-mon',
        'erlang-parsetools',
        'erlang-percept',
        'erlang-public-key',
        'erlang-runtime-tools',
        'erlang-snmp',
        'erlang-ssh',
        'erlang-ssl',
        'erlang-syntax-tools',
        'erlang-tools',
        'erlang-webtool',
        'erlang-xmerl',
    ]

    package { $dependencies: ensure => installed, }

    file { '/usr/sbin/rabbitmqadmin':
        ensure => present,
        owner  => 'root',
        group  => 'root',
        mode   => '0550',
        source => 'puppet:///modules/rabbitmq/rabbitmqadmin',
    }

}
