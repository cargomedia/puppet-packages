node default {

  cm::services::janus { 'default':
    jobs_path => '/opt/janus-cluster/default/var/lib/janus/jobs',
  }
}
