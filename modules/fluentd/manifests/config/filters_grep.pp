define fluentd::config::filters_grep (
  $pattern,
  $priority = 50,
  $rules    = { },
) {

  $rules_resources = grep_rules($rules, {
    'name'     => $name,
    'pattern'  => $pattern,
    'priority' => $priority,
  })
  create_resources('fluentd::config::filter', $rules_resources)
}
