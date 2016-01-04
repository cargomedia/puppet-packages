class chromium::policy::homepage(
  $url
) {

  chromium::policy{ 'homepage':
    content => template("${module_name}/policy/homepage.json.erb"),
  }

}
