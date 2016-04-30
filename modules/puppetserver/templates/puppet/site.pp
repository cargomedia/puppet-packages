# Workaround until upgrading to puppet 4.4
# See https://github.com/cargomedia/puppet-packages/issues/1071
Service { provider => $::service_provider }

node default {

  if ($facts['bootstrap']) {
    <% @bootstrap_classes.each do |bootstrap_class| -%>
    class { '<%= bootstrap_class %>': }
    <% end %>
  } else {
    include hiera_array('classes', [])
  }
}
