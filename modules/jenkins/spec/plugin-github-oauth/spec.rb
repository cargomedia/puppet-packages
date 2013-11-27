require 'spec_helper'

describe file('/var/lib/jenkins/config.xml') do
  its(:content) { should match /cargomedia/ }
  its(:content) { should match /<useSecurity>true<\/useSecurity>/ }
end
