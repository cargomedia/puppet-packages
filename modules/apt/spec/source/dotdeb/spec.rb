require 'spec_helper'

describe file('/etc/apt/sources.list.d/dotdeb.list') do
  it { should be_file }
end
