# Class: lvm::params
#
#
class lvm::params {
  case $operatingsystem {
    'ubuntu', 'debian': {
      $lvm_name = "lvm2"
    }

    'centos', 'redhat', 'fedora', 'scientific': {
      $lvm_name = "lvm2"
    }

    default: {
      fail "Operating system not supported yet."
    }
  }
}
