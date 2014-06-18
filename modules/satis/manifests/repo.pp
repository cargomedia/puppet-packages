define satis::repo ($content) {

  require 'satis'

  $specificationPath = "/etc/satis/${name}.json"
  $outputPath = "/var/lib/satis/public/${name}"

  file {$specificationPath:
    content => $content,
    owner => '0',
    group => '0',
    mode => '0755',
  }
  ~>

  exec {"create satis repo ${name}":
    command => "/var/lib/satis/satis/bin/satis --no-interaction build ${specificationPath} ${outputPath}",
    refreshonly => true,
    cwd => '/var/lib/satis',
    user => 'satis',
    environment => ['HOME=/var/lib/satis'],
  }
  ->

  cron {"cron satis repo ${name}":
    command => "/var/lib/satis/satis/bin/satis --no-interaction --quiet build ${specificationPath} ${outputPath}",
    user    => 'satis',
  }
}
