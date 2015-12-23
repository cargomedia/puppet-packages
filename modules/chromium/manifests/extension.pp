define chromium::extension(
  $id,
  $update_url = 'https://clients2.google.com/service/update2/crx',
) {

  chromium::policy{ "extension-${title}":
    content => template("${module_name}/policy/extension.json.erb"),
  }

}
