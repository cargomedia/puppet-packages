node default {

<% @bootstrap_classes.each do |bootstrap_class| -%>
  class {'<%= bootstrap_class %>': tag => 'bootstrap'}
<% end %>

  include hiera_array('classes', [])
}
