require 'spec_helper'

describe file('/usr/lib/jvm/java-7-oracle') do
  it { should be_directory }
end
