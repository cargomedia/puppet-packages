require 'spec_helper'

describe file('/var/lib/satis/public/foo') do
  it { should be_directory }
  it { should be_owned_by 'satis' }
end

describe file('/var/lib/satis/public/bar') do
  it { should be_directory }
  it { should be_owned_by 'satis' }
end

describe file('/var/lib/satis/public/foo/packages.json') do
  it { should be_file }
  it { should be_owned_by 'satis' }
  it { should be_readable.by_user('www-data') }
end

describe command('grep -r "https://api.github.com/repos/fabpot/Twig/zipball/ca445842fcea4f844d68203ffa2d00f5e3cdea64" /var/lib/satis/public/foo/include') do
  it { should return_exit_status 0 }
end

describe file('/var/lib/satis/public/bar/packages.json') do
  it { should be_file }
  it { should be_owned_by 'satis' }
  it { should be_readable.by_user('www-data') }
end

describe command('grep -r "http://example.com/bar/dist/twig-twig-ca445842fcea4f844d68203ffa2d00f5e3cdea64-zip-db7c39.zip" /var/lib/satis/public/bar/include') do
  it { should return_exit_status 0 }
end

describe file('/var/lib/satis/public/bar/dist/twig-twig-ca445842fcea4f844d68203ffa2d00f5e3cdea64-zip-db7c39.zip') do
  it { should be_file }
  it { should be_owned_by 'satis' }
  it { should be_readable.by_user('www-data') }
end
