require 'spec_helper'

describe 'cm::vhost' do
  redirect_location = /< Location: https:\/\/foo\.xxx\//

  ['bar', 'bor', 'baz'].each do |name|
    describe command("curl --proxy '' -v http://#{name}.xxx") do
      its(:stderr) { should match redirect_location }
    end
  end

  ['www.', 'admin.', ''].each do |name|
    describe command("curl --proxy '' -v http://#{name}foo.xxx") do
      its(:stderr) { should match /< Location: https:\/\/#{name}foo\.#{tld}\// }
    end
  end
end
