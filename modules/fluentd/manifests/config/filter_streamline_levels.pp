class fluentd::config::filter_streamline_levels (
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

  fluentd::config::filter_record_transformer { 'streamline_level':
    pattern  => '**',
    config   => {
      enable_ruby => true,
    },
    record   => {
      level => "\${${level_filter}}",
    },
    priority => $priority,
  }

}
