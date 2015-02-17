require 'spec_helper'

describe 'nginx:vhost' do

  describe command('curl -v http://foo.cm') do
    its(:stderr) { should match /< Location: https:\/\/bar\.cm\//}
  end
end
