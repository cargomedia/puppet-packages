require 'spec_helper'

describe 'apache2::ssl_ca' do

  describe file('/etc/apache2/ssl-ca/.0') do
    it { should be_linked_to 'example.com' }
  end
end
