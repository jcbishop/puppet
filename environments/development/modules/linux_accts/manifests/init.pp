class linux_accts {
  user { "test_user" :
	  ensure     => "absent",
    uid        => "1001",
    gid        => "1001",
    comment    => "Test User",
    home       => "/home/test",
	  managehome => true,
    shell      => "/bin/bash",
	  password   => '$6$saltuser$lMNgoNW1ENTb9W.7YbGppM8Rr35E7kEpxMpYzD2ZOJnruusIaTl9Frnj8E6urDVT6ztyk4CQTHJyPP2Mhcdfo0',
	  require    => Group["test_user_group"]
  }

  group { "test_user_group" :
	  ensure => "present",
	  name   => "test_user",
	  gid    => "1001",
  }
}
