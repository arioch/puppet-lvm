## Sample Usage

    node node01 {
      include lvm
      lvm::lv {
        "device1":
          ensure => present,
          size   => "10G",
          vg     => "vgStorage";
        "device2":
          ensure => absent,
          vg     => "vgStorage";
        "device3":
          ensure => extend,
          size   => "10G",
          vg     => "vgStorage";
        "device4":
          ensure => reduce,
          size   => "10G",
          vg     => "vgStorage";
      }
    }


## Todo

- Physical volume support.
