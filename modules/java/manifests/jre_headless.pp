class java::jre_headless {

  class { 'java::jre':
    headless => true,
  }

}
