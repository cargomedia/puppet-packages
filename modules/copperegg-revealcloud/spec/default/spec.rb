require 'spec_helper'

describe file('/usr/local/revealcloud/revealcloud') do
  it { should be_file }
end
