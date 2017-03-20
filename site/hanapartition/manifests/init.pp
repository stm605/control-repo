# Class: hanapartition
# ===========================
#
# Full description of class hanapartition here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'hanapartition':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class hanapartition {

include selinux
include lvm
include AlexCline::mounts


physical_volume { '/dev/sdc':
  ensure => present,
}

physical_volume { '/dev/sdd':
  ensure => present,
}

physical_volume { '/dev/sde':
  ensure => present,
}

physical_volume { '/dev/sdf':
  ensure => present,
}

volume_group { 'hanavg':
  ensure           => present,
  physical_volumes => ['/dev/sdc', '/dev/sdd', '/dev/sde', '/dev/sdf'],
}

logical_volume { 'datalv':
  ensure       => present,
  volume_group => 'hanavg',
  size         => '700G',
}

logical_volume { 'loglv':
  ensure       => present,
  volume_group => 'hanavg',
  size         => '300G',
}

logical_volume { 'hanasharedlv':
  ensure       => present,
  volume_group => 'hanavg',
  size         => '300G',
}

logical_volume { 'usrsaplv':
  ensure       => present,
  volume_group => 'hanavg',
  size         => '200G',
}

filesystem { '/dev/hanavg/hanasharedlv':
  ensure  => present,
  fs_type => 'xfs',
  options => '-b size=4096 -d su=64k,sw=2',
}

filesystem { '/dev/hanavg/datalv':
  ensure  => present,
  fs_type => 'xfs',
  options => '-b size=4096 -d su=64k,sw=2',
}

filesystem { '/dev/hanavg/loglv':
  ensure  => present,
  fs_type => 'xfs',
  options => '-b size=4096 -d su=64k,sw=2',
}

filesystem { '/dev/hanavg/usrsaplv':
  ensure  => present,
  fs_type => 'xfs',
  options => '-b size=4096 -d su=64k,sw=2',
}

mounts { 'Mount point for hanashared':
  ensure => present,
  source => '/dev/hanavg/hanasharedlv',
  dest   => '/hana/shared',
  type   => 'xfs',
  opts   => 'nofail,defaults,noatime',
}

mounts { 'Mount point for datalv':
  ensure => present,
  source => '/dev/hanavg/datalv',
  dest   => '/hana/data',
  type   => 'xfs',
  opts   => 'nofail,defaults,noatime',
}


mounts { 'Mount point for loglv':
  ensure => present,
  source => '/dev/hanavg/loglv',
  dest   => '/hana/log',
  type   => 'xfs',
  opts   => 'nofail,defaults,noatime',
}


mounts { 'Mount point for sap':
  ensure => present,
  source => '/dev/hanavg/usrsaplv',
  dest   => '/usr/sap',
  type   => 'xfs',
  opts   => 'nofail,defaults,noatime',
}

}
