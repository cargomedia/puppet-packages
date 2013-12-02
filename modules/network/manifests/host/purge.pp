class network::host::purge {

  resources {'host':
    purge => true,
  }
}
