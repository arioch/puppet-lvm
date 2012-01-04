# Define: lv
# Parameters:
# ensure, vg, size=NONE
#
define lvm::lv ( $ensure = present, $vg, $size = undef ) {
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