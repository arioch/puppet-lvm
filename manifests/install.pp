class lvm::install {
  package {
    $lvm::params::lvm_name:
      ensure => present;
  }
}