require 'spec_helper'

describe 'chromium::policy::extension' do

  describe file('/etc/chromium-browser/policies/managed/homepage.json') do
    its(:content) { should match('"HomepageLocation": "http://www.example.com"')}
  end

end
