# == Class: consul_template
#
# Full description of class consul_template here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'consul_template':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class consul_template(
  # Module Settings
  $consul         = undef,
  $token          = undef,
  $version        = '0.3.1',

  # Module Config
  $bin_dir        = '/usr/local/bin',
  $conf_dir       = '/etc/consul_template',
  $init_style     = 'upstart',
  $service_ensure = 'running',
  $service_enable = true,
  $user           = 'root',
  $group          = 'root',
) {
  class { 'consul_template::install': }
  -> class { 'consul_template::config': }
  ~> class { 'consul_template::service': }
  -> Class['consul_template']
}
