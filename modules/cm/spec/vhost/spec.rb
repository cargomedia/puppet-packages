require 'spec_helper'

describe 'nginx:vhost' do
  redirect_location = /< Location: https:\/\/www\.foo\.cm\//

  ['bar', 'bor', 'baz'].each do |name|
    describe command("curl --proxy '' -v http://#{name}.cm") do
      its(:stderr) { should match redirect_location }
    end
  end

  ['www.', 'admin.', ''].each do |name|
    describe command("curl --proxy '' -v http://#{name}foo.xx") do
      its(:stderr) { should match /< Location: https:\/\/#{name}foo\.xx\// }
    end
  end
end
