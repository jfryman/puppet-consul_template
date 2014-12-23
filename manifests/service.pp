class consul_template::service {
  $_service_ensure = $consul_template::service_ensure
  $_service_enable = $consul_template::service_enable

  service { 'consul_template':
    ensure => $_service_ensure,
    enable => $_service_enable,
  }
}
