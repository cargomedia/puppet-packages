Facter.add("fqdn_reversed") do
  setcode do
    Facter.value('fqdn').split('.').reverse.join('.')
  end
end
