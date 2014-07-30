require 'spec_helper'

describe command('ps aux | grep elasticsearch') do
  its(:stdout) { should match 'java -Xms256m -Xmx1g' }
end
