require 'spec_helper'

describe 'apt::source::dotdeb' do

  describe file('/etc/apt/sources.list.d/nodesource.list') do
    it { should be_file }
  end
end
