require 'spec_helper'

describe 'java::jre' do

  describe command('java -version') do
    its(:exit_status) { should eq 0 }
  end

  describe command('ls -d /usr/lib/jvm/java-7-openjdk*') do
    its(:exit_status) { should eq 0 }
  end

end
