require 'spec_helper'

describe group('cacti') do
  it { should exist }
end

describe group('cacti') do
  it { should have_gid 3001 }
end

describe user('cacti') do
  it { should exist }
end

describe user('cacti') do
  it { should have_uid 3001 }
end

describe user('cacti') do
  it { should belong_to_group 'cacti' }
end

describe user('cacti') do
  it { should have_home_directory '/home/cacti' }
end

describe user('cacti') do
  it { should have_authorized_key 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9TeArXpgEOycGcdpNjYYw8oA5mRQE4/UpLRHmllH9Ly666/pFt9I3n2AiL0NMZPEslKKdqesv/qlUmqbP2JIMGjpu6OYceNyeFrsLgUqKR4D8ggBm7DnTPBxqXRqrlXG9Pk7hd8HrVYa53ELtOykCGK/jtTHucGzmemVyXDyPjxGouwOtz4gCCbPRAdEqoQnkgXWwCZzzJfQe1I30utY/PI+5rvJ6bGY/gYnL877xDVhEC8El4OR1oeuyTXl1MRt7E2YLECnD4kDOBn3lViDFlgSgOV8OUS9pE1uvMkofyBq1O5OYfNUvnob5nX+BFb7vTL3pO8XbQibpNvi+i/D9 cacti' }
end
