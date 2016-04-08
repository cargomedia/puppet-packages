define fluentd::config::filter_streamline_level (
  $pattern = '**',
  $priority = 50,
) {

  $replacements = {
    ''              => 'info',
    'trace'         => 'debug',
    'informational' => 'info',
    'warn'          => 'warning',
    'notice'        => 'warning',
    'critical'      => 'fatal',
    'alert'         => 'fatal',
    'emergency'     => 'fatal',
    'emerg'         => 'fatal',
  }
  $level_filter = inline_template('level = record["level"].to_s.downcase; <%= @replacements.inspect %>[level] || level')

  fluentd::config::filter_record_modifier{ 'streamline_level':
    pattern  => '**',
    record   => {
      level => "\${${level_filter}}",
    },
    priority => $priority,
  }

}
