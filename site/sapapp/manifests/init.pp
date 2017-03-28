# Class: sapapp
# ===========================
#
# Full description of class sapapp here.
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
#    class { 'sapapp':
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
class sapapp {


  group { 'sapinst':
    ensure => 'present',
  }

  file { '/silent':
    ensure => 'directory',
    owner  => 'root',
    group  => 'sapinst',
    mode   => '0775',
  }

    
#put required files into silent directory
file { '/silent/doc.dtd':
  ensure => file,
  content => epp('sapapp/doc.dtd.epp')
}

file { '/silent/inifile.xml':
  ensure => file,
  content => epp('sapapp/inifile.xml.epp')
}

file { '/silent/keydb.dtd':
  ensure => file,
  content => epp('sapapp/keydb.dtd.epp')
}

file { '/silent/start_dir.cd':
  ensure => file,
  content => epp('sapapp/start_dir.cd.epp')
}

file { '/silent/sapinst.sh':
  ensure => file,
  content => epp('sapapp/sapinst.sh.epp')
}

  exec { "chown silent and sapbits":
       command => "chown -R root:sapinst /silent /mnt/sapbits",
    path    => '/bin:/usr/bin:/usr/sbin',
    }

  exec { "chmod silent and sapbits" :
       command => "chmod -R 775 /silent /mnt/sapbits",
           path    => '/bin:/usr/bin:/usr/sbin',
       }



#exec { "install_start_sapapp":
#     command	=> "/mnt/sapbits/SWPM10_SP19_Patches/Sapinst SAPINST_PARAMETER_CONTAINER_URL=inifile.xml SAPINST_EXECUTE_PRODUCT_ID=NW_ABAP_OneHost:BS2016.ERP608.HDB.PD SAPINST_SKIP_DIALOGS=true -nogui -noguiserver",
#     cwd => '/silent',
#     path    => '/bin:/usr/bin:/usr/sbin:./',
#     unless  => 'sudo -u hdbadm bash -l /usr/sap/HDB/HDB00/HDB info 2>&1 | grep# hdbnameserver',
#     require => File['/root/HDB_BatchInst'],
#     timeout => '0',
#     environment => "HDB_MASSIMPORT=yes",
#}

 

#run the actual install
# /mnt/sapbits/HANA_51051151/DATA_UNITS/HDB_LCM_LINUX_X86_64

#exec { "install_start_hana":
#     command	=> "/mnt/sapbits/HANA_51051151/DATA_UNITS/HDB_LCM_LINUX_X86_64/h#dblcm -b --configfile /root/HDB_BatchInst",
#     cwd => '/mnt/sapbits/HANA_51051151/DATA_UNITS/HDB_LCM_LINUX_X86_64',
#     path    => '/bin:/usr/bin:/usr/sbin:./',
#     unless  => 'sudo -u hdbadm bash -l /usr/sap/HDB/HDB00/HDB info 2>&1 | grep# hdbnameserver',
#     require => File['/root/HDB_BatchInst'],
#     timeout => '0'
#}

}
