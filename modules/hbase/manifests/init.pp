class hbase {
  $hbase_home = "/opt/hbase"

  exec { "download_grr":
    command => "wget --no-check-certificate http://raw.github.com/fs111/grrrr/master/grrr -O /tmp/grrr && chmod +x /tmp/grrr",
    path => $path,
    creates => "/tmp/grrr",
  }

  exec { "download_hbase":
    command => "wget http://mirror.gopotato.co.uk/apache/hbase/hbase-0.94.10/hbase-0.94.10.tar.gz -O /vagrant/hbase.tar.gz --read-timeout=5 --tries=0",
    timeout => 1800,
    path => $path,
    unless => "ls /vagrant | grep hbase.tar.gz",
    require => [ Package["openjdk-6-jdk"], Exec["download_grrr"] ]
  }

  exec { "unpack_hbase":
    command => "tar xf /vagrant/hbase.tar.gz -C /opt",
    path => $path,
    creates => "${hbase_home}-0.94.10",
    require => Exec["download_hbase"]
  }

  file {
    "${hbase_home}-0.94.10/conf/hbase-site.xml":
      source => "puppet:///modules/hbase/hbase-site.xml",
      mode => 644,
      owner => root,
      group => root,
      require => Exec["unpack_hbase"]
  }

  file {
    "${hbase_home}-0.94.10/conf/hbase-env.sh":
      source => "puppet:///modules/hbase/hbase-env.sh",
      mode => 644,
      owner => root,
      group => root,
      require => Exec["unpack_hbase"]
  }

  file {
    "${hbase_home}-0.94.10/conf/regionservers":
      source => "puppet:///modules/hbase/regionservers",
      mode => 644,
      owner => root,
      group => root,
      require => Exec["unpack_hbase"]
  }

  exec { "start_master":
    command => "${hbase_home}-0.94.10/bin/start-hbase.sh",
    path => $path,
    require => [ File["${hbase_home}-0.94.10/conf/hbase-site.xml"], File["${hbase_home}-0.94.10/conf/hbase-env.sh"], File["${hbase_home}-0.94.10/conf/regionservers"] ]
  }

}
