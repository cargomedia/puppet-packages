require 'spec_helper'

describe 'screenconnect' do

  describe process('java') do
    its(:args) { should match('-classpath /opt/screenconnect-') }
  end

end
