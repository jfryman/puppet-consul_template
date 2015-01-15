class consul_template::config {
  $_conf_dir = $consul_template::conf_dir
  $_consul   = $consul_template::consul
  $_token    = $consul_template::token
  $_user     = $consul_template::user
  $_group    = $consul_template::group

  file { $_conf_dir:
    ensure => directory,
    owner  => $_user,
    group  => $_group,
    mode   => '0755',
  }

  concat { "${_conf_dir}/consul_template.hcl":
    ensure  => present,
    require => File[$_conf_dir],
    notify  => Class['::consul_template::service'],
  }
  concat::fragment { 'consul_template::server_settings':
    target => "${_conf_dir}/consul_template.hcl",
    order  => '01',
    content => template('consul_template/conf_server_settings.erb'),
  }
}
