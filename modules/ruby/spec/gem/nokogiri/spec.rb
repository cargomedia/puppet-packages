require 'spec_helper'

describe 'ruby::gem::nokogiri' do

  describe command('gem list') do
    its(:stdout) { should match 'nokogiri' }
  end
end
