require 'spec_helper'

describe 'kernel' do

  describe file('/etc/modules') do
    it { should be_file }
  end

  entries = ['loop', 'foo', 'bar']

  describe file('/etc/modules') do
    entries.each do |entry|
      its(:content) { should match /#{entry}/ }
    end
  end
end
