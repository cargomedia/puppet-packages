require 'spec_helper'

describe 'apache::mod::ssl' do

  describe command('apachectls -M') do
    its(:stdout) { should match 'ssl_module' }
  end
end
