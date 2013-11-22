node default {
  class {'kernel' :
    modules => ['loop', 'foo', 'bar'],
  }
}