node default {

  if ($bootstrap) {
    <% @bootstrap_classes.each do |bootstrap_class| -%>
    class { '<%= bootstrap_class %>': }
    <% end %>
  } else {
    include hiera_array('classes', [])
  }
}
