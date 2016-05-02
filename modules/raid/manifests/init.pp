class raid(
  $controllers = undef
) {

  $controller_list = $controllers ? {
    undef => split($::facts['raid'], ','),
    default => $controllers,
  }

  include prefix($controller_list, 'raid::')

}
