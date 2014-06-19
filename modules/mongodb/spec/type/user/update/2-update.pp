node default {

  mongodb_user {'testuser':
    database => 'testdb',
    password => 'my-password3',
    roles => [ {"role" => "read", "db"=> "testdb"} ],
  }

}
