require 'spec_helper'

describe command('librarian-puppet version') do
  it { should return_exit_status 0 }
  its(:stdout) { should match /librarian-puppet/ }
end
