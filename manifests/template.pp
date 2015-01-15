define consul_template::template(
  $destination = $name,
  $source      = undef,
  $command     = undef,
) {
  $_conf_dir = $consul_template::conf_dir

  concat::fragment { "consul_template::${name}":
    target => "${_conf_dir}/consul_template.hcl",
    order  => '10',
    content => template('consul_template/conf_template.erb'),
  }
}
