class sysctl::entry::core_pattern(
  $pattern = '/tmp/core.%e.%p.%h.%t'
) {

  sysctl::entry { 'kernel-core-pattern':
    entries => {
      'kernel.core_pattern' => $pattern,
    }
  }
}
