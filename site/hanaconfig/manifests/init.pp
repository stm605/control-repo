# Class: hanaconfig
# ===========================
#
# Full description of class hanaconfig here.
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
#    class { 'hanaconfig':
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
class hanaconfig {


include disable_transparent_hugepage

class { '::selinux':
  mode => 'disabled',
}


# disable NUMA balancing
#file { '/etc/sysctl.d/sap_hana.conf':
#  ensure => file,
#  content => 'kernel.numa_balancing=0',
#} 

sysctl { 'kernel.numa_balancing': value => '0' }

#diable ABRT, core dumps and kdump
class { 'abrt':
  active => false,
}

#disable core dump
limits::fragment {
 "*/soft/core":
   value => "0";
 "*/hard/core":
   value => "0";
}

#disable kdump service
class { 'kdump':
  enable => false,
}

#diable firewall.  better practice will be to open specific holes in the firewall
exec { "stop_firewall":
     command	=> "systemctl stop firewalld", 
    path    => '/bin:/usr/bin:/usr/sbin',
}

exec { "disable_firewall":
     command	=> "systemctl disable firewalld",
    path    => '/bin:/usr/bin:/usr/sbin',
}

#install the latest version of waagent
yum::install { 'WALinuxAgent-2.2.4-1.el7.noarch':
  ensure => present,
  source => 'WALinuxAgent-2.2.4-1.el7.noarch',
}


#install additional RHEL required packages
yum::group {'base':
  ensure => present
}

package { 'gtk2': ensure => 'installed' }
package { 'libicu': ensure => 'installed' }
package { 'xulrunner': ensure => 'installed' }
package { 'sudo': ensure => 'installed' }
package { 'tcsh': ensure => 'installed' }
package { 'libssh2': ensure => 'installed' }
package { 'expect': ensure => 'installed' }
package { 'cairo': ensure => 'installed' }
package { 'graphviz': ensure => 'installed' }
package { 'iptraf-ng': ensure => 'installed' }
package { 'krb5-workstation': ensure => 'installed' }
package { 'krb5-libs': ensure => 'installed' }
package { 'libpng12': ensure => 'installed' }
package { 'nfs-utils': ensure => 'installed' }
package { 'lm_sensors': ensure => 'installed' }
package { 'rsyslog': ensure => 'installed' }
#package { 'openssl1098e': ensure => 'installed' }
package { 'openssl': ensure => 'installed' }
package { 'PackageKit-gtk3-module': ensure => 'installed' }
package { 'libcanberra-gtk2': ensure => 'installed' }
package { 'libtool-ltdl': ensure => 'installed' }
package { 'xorg-x11-xauth': ensure => 'installed' }
package { 'numactl': ensure => 'installed' }
package { 'xfsprogs': ensure => 'installed' }
package { 'net-tools': ensure => 'installed' }
package { 'bind-utils': ensure => 'installed' }
#package { 'openssl098e': ensure => 'installed' }
package { 'chrony' : ensure => 'installed' }

service { 'chronyd':
	ensure => 'running',
}



#set symbolic links
# keep in mind, the target is the actual file, and the
# title is the link name
#
file { '/usr/lib64/libssl.so.0.9.8':
     ensure => 'link',
     target => '/usr/lib64/libssl.so.0.9.8e',
}


file { '/usr/lib64/libssl.so.1.0.1':
     ensure => 'link',
     target => '/usr/lib64/libssl.so.1.0.1e',
}

file { '/usr/lib64/libcrypto.so.0.9.8':
     ensure => 'link',
     target => '/usr/lib64/libcrypto.so.0.9.8e',
}

file { '/usr/lib64/libcrypto.so.1.0.1':
     ensure => 'link',
     target => '/usr/lib64/libcrypto.so.1.0.1e',
}

#RHEL settings for SAP HANA
kernel_parameter { "processor.max_cstate":
  ensure  => present,
  value   => "1",
}

kernel_parameter { "intel_idle.max_cstate":
  ensure  => present,
  value   => "1",
}


}
