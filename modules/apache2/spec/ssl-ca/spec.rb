require 'spec_helper'

describe file('/etc/apache2/ssl-ca/.0') do
  it { should be_linked_to 'example.com' }
end
