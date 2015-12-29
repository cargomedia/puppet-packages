require 'spec_helper'

describe 'build:all' do

  packages = [
    'libglib2.0-dev',
    'libjansson-dev',
    'zlib1g-dev',
    'automake',
    'cmake',
    'libtool',
    'pkg-config',
  ]

  packages.each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
  end
end
