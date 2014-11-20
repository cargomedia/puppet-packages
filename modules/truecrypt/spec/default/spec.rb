require 'spec_helper'

describe command('truecrypt --help') do
  it { should return_exit_status 0 }
end
