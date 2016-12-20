require 'spec_helper'

describe 'nginx::with-php' do

  describe command('nginx -t') do
    its(:exit_status) { should eq 0 }
  end

end
