Facter.add(:external_ip) do
  setcode do
    Facter::Core::Execution.exec('dig +short myip.opendns.com @resolver1.opendns.com')
  end
end
