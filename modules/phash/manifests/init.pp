class phash {

  Package { ensure => "installed" }

  # $packs = [ "g++", "libphash0", "libphash0-dev" ]
  $packs = [ "libphash0"  ]

  package { $packs: }

}
