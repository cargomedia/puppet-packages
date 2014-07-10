require 'spec_helper'

describe command('/usr/local/revealcloud/revealcloud -V') do
  it(:stdout) { should match /v3\.3-9-g06271da/ }
end

