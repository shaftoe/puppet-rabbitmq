
#
# Downloads a file
#
# Parameters:
#
# $url::         The remote url
# $destination:: The destination file
# $unless::      If this parameter is set, then this exec will run unless
#                the command returns 0
#
define rabbitmq::downloader($url, $destination, $unless = '/bin/false') {

  exec { "download_${url}_to_${destination}":
    command     => "/usr/bin/wget --no-check-certificate -O '${destination}' '${url}'",
    creates     => $destination,
    unless      => $unless,
    timeout     => 0
  }

}
