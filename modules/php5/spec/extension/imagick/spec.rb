require 'spec_helper'

describe 'php5::extension::imagick' do

  describe command('php --ri imagick') do
    its(:exit_status) { should eq 0 }
  end

  describe file('/var/log/php/error.log') do
    its(:content) { should_not match /Warning.*imagick.*already loaded/ }
  end

  describe command('php -r "echo join(PHP_EOL, Imagick::queryformats());"') do
    its(:stdout) { should match('^JPEG$') }
    its(:stdout) { should match('^PNG$') }
    its(:stdout) { should match('^SVG$') }
  end

end
