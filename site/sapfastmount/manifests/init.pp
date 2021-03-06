# Class: sapfastmount
# ===========================
#
# Full description of class sapfastmount here.
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
#    class { 'sapfastmount':
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
class sapfastmount {

include lvm

physical_volume { '/dev/sdc':
  ensure => present,
}

volume_group { 'sapbitsvg':
  ensure           => present,
  physical_volumes => ['/dev/sdc'],
}

logical_volume { 'sapbitslv':
  ensure       => present,
  volume_group => 'sapbitsvg',
  size         => '900G',
}

filesystem { '/dev/sapbitsvg/sapbitslv':
  ensure  => present,
  fs_type => 'xfs',
  options => '-b size=4096 -d su=64k,sw=2',
}

mounts { 'Mount point sapbits':
  ensure => present,
  source => '/dev/sapbitsvg/sapbitslv',
  dest   => '/mnt/sapbits',
  type   => 'xfs',
}

#now that sapbits is created, copy the data to it
package { 'cifs-utils': ensure => 'installed' }

#

$theopts = "vers=3.0,username=sapbitseastus2,password=xFN8vqjuNmZJylg4y++fEpM4WeJAd3jLMiA1zlJtGik5n1aKgWo/Vk0pXg1h9ke37XI8USw88Eq0gE/2zrtmuQ==,dir_mode=0777,file_mode=0777"

mounts { 'sapmount2':
  ensure => present,
  source => '//sapbitseastus2.file.core.windows.net/linuxsapbits',
  dest   => '/mnt/sapbits2',
  type   => 'cifs',
  opts   => $theopts,
}

exec { "extract linuxsapbits.tar" :
   command => "tar -xzf /mnt/sapbits2/linuxsapbits.tar.gz",
   unless => "find /mnt/sapbits 2>&1 | grep  HANA_51051151",
   creates => "/mnt/sapbits/HANA_51051151",
   cwd => "/mnt/sapbits",
    path    => '/bin:/usr/bin:/usr/sbin',
    timeout => '0',
    }
}
