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

#mounts { 'sapmount':
#  ensure => present,
#  source => '\\\\sapbitseastus2.file.core.windows.net\\linuxsapbits',
#  dest   => '/mnt/sapbits',
#  type   => 'cifs',
#  opts   => 'vers=3.0,dir_mode=0777,file_mode=0777,username=sapbitsus2,password="xFN8vqjuNmZJylg4y++fEpM4WeJAd3jLMiA1zlJtGik5n1aKgWo/Vk0pXg1h9ke37XI8USw88Eq0gE/2zrtmuQ=="',
#}

$pwe = '='
notify { "pwe = ${pwe}" : }

$dequals = "${pwe}${pwe}"
notify { "dequals = ${dequals}" : }

$theopts = "vers=3.0,username=sapbitseastus2,password=xFN8vqjuNmZJylg4y++fEpM4WeJAd3jLMiA1zlJtGik5n1aKgWo/Vk0pXg1h9ke37XI8USw88Eq0gE/2zrtmuQ${dequals},dir_mode=0777,file_mode=0777"

notify { "theopts = ${theopts}" : }

mounts { 'sapmount':
  ensure => present,
  source => '//sapbitseastus2.file.core.windows.net/linuxsapbits',
  dest   => '/mnt/sapbits',
  type   => 'cifs',
  opts   => $theopts,
}



#sudo mount -t cifs //sapbitseastus2.file.core.windows.net/linuxsapbits
#/mnt/sapbits -o vers=3.0,username=sapbitseastus2,password=xFN8vqjuNmZJylg4y++fEpM4WeJAd3jLMiA1zlJtGik5n1aKgWo/Vk0pXg1h9ke37XI8USw88Eq0gE/2zrtmuQ==,dir_mode=0777,file_mode=0777
#

}
