class rootpw {
  $root_pw = hiera(server:root:password)
  user { 'root':
    ensure  => 'present',
    password  => sha512('$root_pw'),
  }
}
