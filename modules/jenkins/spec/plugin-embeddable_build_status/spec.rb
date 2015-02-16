require 'spec_helper'

describe 'jenkins::plugin::embeddable_build_status' do

  describe file('/var/lib/jenkins/plugins/embeddable-build-status.hpi') do
    it { should be_file }
  end
end
