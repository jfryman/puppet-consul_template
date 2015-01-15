class consul_template::install {
  $_bin_dir      = $consul_template::bin_dir
  $_conf_dir     = $consul_template::conf_dir
  $_init_style   = $consul_template::init_style
  $_user         = $consul_template::user
  $_group        = $consul_template::group
  $_version      = $consul_template::version
  $_download_url = "https://github.com/hashicorp/consul-template/releases/download/v${_version}/consul-template_${_version}_linux_amd64.tar.gz"

  staging::file { 'consul_template.tar.gz':
    source     => $_download_url,
  } ->
  staging::extract { 'consul_template.tar.gz':
    target => $_bin_dir,
    creates => "${_bin_dir}/consul-template_${_version}_linux_amd64",
  } ->
  file { "${_bin_dir}/consul-template":
    owner => 'root',
    group => 'root',
    mode  => '0555',
    source => "${_bin_dir}/consul-template_${_version}_linux_amd64/consul-template",
  }

  case $_init_style {
    'upstart' : {
      file { '/etc/init/consul_template.conf':
        mode   => '0444',
        owner   => 'root',
        group   => 'root',
        content => template('consul_template/consul_template.upstart.erb'),
      }
      file { '/etc/init.d/consul_template':
        ensure => link,
        target => "/lib/init/upstart-job",
        owner  => root,
        group  => root,
        mode   => 0755,
      }
    }
    default : {
      fail("I don't know how to create an init script for style $_init_style")
    }
  }
}
