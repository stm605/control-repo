# Class: sapmount
# ===========================
#
# Full description of class sapmount here.
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
#    class { 'sapmount':
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
class sapmount {

package { 'cifs-utils': ensure => 'installed' }

mounts { 'sapmount':
  ensure => present,
  source => '\\\\sapbits.file.core.windows.net\\linuxsapbits',
  dest   => '/mnt/sapbits',
  type   => 'cifs',
  opts   => 'vers=2.1,dir_mode=0777,file_mode=0777,username=sapbits,password="2pjPgyxzaXzvZf/MseNWjx9g1C0i2T5gu3caGqonaar/Xx47MiUemYyLN8ITQdKAfDiI81tCs0xmV2kV0LakRg=="',
}



}
