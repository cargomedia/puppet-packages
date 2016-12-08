node default {

  $rules = @(RULES)

  *filter
  -A ufw-before-input -m comment --comment "foo bar rule"
  COMMIT

  | RULES

  ufw::rules::before { 'foo':
    rules_content => $rules,
  }
}
