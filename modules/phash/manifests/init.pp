class phash {

  Package { ensure => "installed" }

  $packs = [ "g++", "libphash0", "libphash0:i386", "libphash0-dev", "libphash0-dev:i386" ]

  package { $packs: }

}
