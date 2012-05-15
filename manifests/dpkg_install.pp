
#
# Installs a .deb package
#
define rabbitmq::dpkg_install($url, $version) {

  # Config
  $work_dir = '/tmp'
  $tmp_file = "${title}-${version}.deb"

  # Detect if the package has already been installed
  $unless = "/bin/bash -c \"[ `/usr/bin/dpkg-query --showformat='\${Version}' --show ${title}` == '$version' ]\""

  # Download
  rabbitmq::downloader { "download_${url}":
    url         => $url,
    destination => "${work_dir}/${tmp_file}",
    unless      => $unless
  }

  # Install
  exec { "install_${url}":
    command     => "/usr/bin/dpkg -i '${work_dir}/${tmp_file}'",
    require     => Rabbitmq::Downloader[ "download_${url}" ],
    unless      => $unless
  }

  # Remove temporary files
  file { "purge_${url}":
    ensure      => absent,
    path        => "${work_dir}/${tmp_file}",
    require     => [
      Rabbitmq::Downloader[ "download_${url}"],
      Exec[ "install_${url}"],
    ],
  }
}
