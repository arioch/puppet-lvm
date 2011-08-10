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
#	include lvm
#	lvm::lv {
#		"device1":
#			ensure => present,
#			size   => "10G",
#			vg     => "vgStorage";
#		"device2":
#			ensure => absent,
#			vg     => "vgStorage";
#		"device3":
#			ensure => extend,
#			size   => "10G",
#			vg     => "vgStorage";
#		"device4":
#			ensure => reduce,
#			size   => "10G",
#			vg     => "vgStorage";
#	}
#
class lvm {
	# Define: lv
	# Parameters:
	# ensure, vg, size=NONE
	#
	define lv (ensure, vg, size=NONE) {
		case $ensure {
			present: {
				exec { "Create LVM device /dev/${vg}/${name}":
					command => "lvcreate -L ${size} --name ${name} ${vg}",
					unless  => "test -e /dev/${vg}/${name}",
				}
			}

			extend: {
				exec { "Extend LVM device /dev/${vg}/${name}":
					command => "lvextend -L +${size} /dev/${vg}/${name}",
					onlyif  => "test -e /dev/${vg}/${name}",
				}
			}

			reduce: {
				exec { "Reduce LVM device /dev/${vg}/${name}":
					command => "lvreduce --force -L -${size} /dev/${vg}/${name}",
					onlyif  => "test -e /dev/${vg}/${name}",
				}
			}

			absent: {
				exec { "Remove LVM device /dev/${vg}/${name}":
					command => "lvremove --force /dev/${vg}/${name}",
					onlyif  => "test -e /dev/${vg}/${name}",
				}
			}
		}
	}

	# Class: install
	#
	#
	class install {
		package {
			"lvm":
				name   => "$lvm::params::lvm_name",
				ensure => present;
		}
	}

	include install
}
