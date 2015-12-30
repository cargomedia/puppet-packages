node default {

  class{ 'coturn':
    mice => true,
    static_user_accounts => ['admin:admin', 'super:super'],
    realm => 'mydomain.com'
  }
}
