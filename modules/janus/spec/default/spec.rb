require 'spec_helper'

describe 'janus' do

  describe service('janus') do
    it { should be_enabled }
  end

end
