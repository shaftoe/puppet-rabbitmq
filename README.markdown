# Puppet-rabbitmq #

This module manages installation for rabbitmq-server, including setup for users, queues and exchanges.

## Requirements ##

No special requirements, but it's Debian-like specific so if you want to run it on other distributions you may edit a few parts for sure.

Written and tested using Puppet version 2.6.2

## Define custom queues ##

To define custom queues, add rabbit::queue resources like these:

    rabbitmq::queue { 'myqueue': }
    rabbitmq::queue { 'anotherqueue': }
