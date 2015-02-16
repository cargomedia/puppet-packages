require 'spec_helper'

describe 'librarian_puppet' do

  describe command('librarian-puppet version') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /librarian-puppet/ }
  end
end
