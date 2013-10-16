require 'puppet/face'

Puppet::Face.define(:repo, '0.0.1') do
  copyright "Cargomedia", 2013

  action :install do
    when_invoked do |name, url, options|
      system('puppet apply -e "puppet::git-modules {\'' + name+ '\': cloneUrl => \'' + url + '\'}"')
      true
    end

    when_rendering :console do |output, name, url, options|
      'Repo `' + name + '` (' + url + ') added'
    end
  end
end