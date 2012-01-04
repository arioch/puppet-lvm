# Class: LVM
#
# This class installs LVM
#
# Parameters:
#
# Actions:
#   - Install LVM
#   - Manage LVM devices
#
# Requires:
#
# Sample Usage:
#
# include lvm
# lvm::lv {
#   "device1":
#     ensure => present,
#     size   => "10G",
#     vg     => "vgStorage";
#   "device2":
#     ensure => absent,
#     vg     => "vgStorage";
#   "device3":
#     ensure => extend,
#     size   => "10G",
#     vg     => "vgStorage";
#   "device4":
#     ensure => reduce,
#     size   => "10G",
#     vg     => "vgStorage";
# }
#
class lvm () {
  include motd
  motd::register{'lvm': }

  class { 'lvm::params': }
  class { 'lvm::install': }

  Class['lvm::params'] ->
  Class['lvm::install']
}