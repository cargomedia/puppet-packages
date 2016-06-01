node default {

  if $::facts['lsbdistcodename'] == 'wheezy' {
    notify { 'Not compatible with Wheezy - Skipping test': }
  } else {
    class { 'fluentd::plugin::sentry': }
  }
}
