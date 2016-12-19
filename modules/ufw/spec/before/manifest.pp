node default {

  $rules = @(RULES)

  *filter
  -A ufw-before-input -s 192.168.155.155
  COMMIT

  | RULES

  ufw::rules::before { 'foo':
    rules_content => $rules,
  }
}
