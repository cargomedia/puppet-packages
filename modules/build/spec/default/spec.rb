require 'spec_helper'

describe 'build' do

  describe package('make') do
    it { should be_installed }
  end

  describe package('g++') do
    it { should be_installed }
  end

  describe package('gcc') do
    it { should be_installed }
  end

  describe package('autoconf') do
    it { should be_installed }
  end

end
