require 'spec_helper'

describe 'jenkins::plugin::git' do

  describe file('/var/lib/jenkins/plugins/ansicolor.hpi') do
    it { should be_file }
  end
end
