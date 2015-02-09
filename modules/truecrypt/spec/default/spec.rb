require 'spec_helper'

describe command('truecrypt --help') do
  its(:exit_status) { should eq 0 }
end
