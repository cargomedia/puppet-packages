require 'spec_helper'

describe 'jenkins::plugin::git' do

  describe file('/var/lib/jenkins/hudson.plugins.git.GitSCM.xml') do
    its(:content) { should match /<globalConfigName>foo<\/globalConfigName>/ }
    its(:content) { should match /<globalConfigEmail>bar@example.com<\/globalConfigEmail>/ }
  end
end
