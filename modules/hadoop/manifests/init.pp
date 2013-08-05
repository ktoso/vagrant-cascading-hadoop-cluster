class hadoop {
  $hadoop_home = "/opt/hadoop"

# $hadoop_version = "1.1.2"
  $hadoop_version = "2.0.5-alpha"

  exec { "download_grrr":
    command => "wget --no-check-certificate http://raw.github.com/fs111/grrrr/master/grrr -O /tmp/grrr && chmod +x /tmp/grrr",
    path => $path,
    creates => "/tmp/grrr",
  }

  exec { "download_hadoop":
    command => "/tmp/grrr /hadoop/common/hadoop-${hadoop_version}/hadoop-${hadoop_version}.tar.gz -O /vagrant/hadoop.tar.gz --read-timeout=5 --tries=0",
    timeout => 1800,
    path => $path,
    unless => "ls /vagrant | grep hadoop.tar.gz",
    require => [ Package["openjdk-6-jdk"], Exec["download_grrr"]]
  }

  exec { "unpack_hadoop" :
    command => "tar xf /vagrant/hadoop.tar.gz -C /opt && ln -s ${hadoop_home}-${hadoop_version} /opt/hadoop",
    path => $path,
    creates => "${hadoop_home}-${hadoop_version}",
    require => Exec["download_hadoop"]
  }

  exec { "make_links" :
    command => "cd /opt/hadoop && ln -s etc etc",
    path => "/opt/hadoop",
    creates => "/opt/hadoop/etc",
    require => Exec["unpack_hadoop"]
  }

  file {
    "${hadoop_home}/etc/slaves":
      source => "puppet:///modules/hadoop/slaves",
      mode => 644,
      owner => root,
      group => root,
      require => Exec["unpack_hadoop"]
  }

  file {
    "${hadoop_home}/etc/masters":
      source => "puppet:///modules/hadoop/masters",
      mode => 644,
      owner => root,
      group => root,
      require => Exec["unpack_hadoop"]
  }

  file {
    "${hadoop_home}/etc/core-site.xml":
      source => "puppet:///modules/hadoop/core-site.xml",
      mode => 644,
      owner => root,
      group => root,
      require => Exec["unpack_hadoop"]
  }

  file {
    "${hadoop_home}/etc/mapred-site.xml":
      source => "puppet:///modules/hadoop/mapred-site.xml",
      mode => 644,
      owner => root,
      group => root,
      require => Exec["unpack_hadoop"]
  }

  file {
    "${hadoop_home}/etc/hdfs-site.xml":
      source => "puppet:///modules/hadoop/hdfs-site.xml",
      mode => 644,
      owner => root,
      group => root,
      require => Exec["unpack_hadoop"]
  }

  file {
    "${hadoop_home}/etc/hadoop-env.sh":
      source => "puppet:///modules/hadoop/hadoop-env.sh",
      mode => 644,
      owner => root,
      group => root,
      require => Exec["unpack_hadoop"]
  }

  file { "/etc/profile.d/hadoop-path.sh":
    source => "puppet:///modules/hadoop/hadoop-path.sh",
    owner => root,
    group => root,
  }

}
