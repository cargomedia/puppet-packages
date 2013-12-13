require 'spec_helper'

describe file('/usr/lib/jvm/java-6-openjdk') do
  it { should be_directory }
end
