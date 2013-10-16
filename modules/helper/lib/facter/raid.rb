require 'set'
if Facter.value(:kernel) == "Linux"
  Facter.add("raid") do
    confine :kernel => :linux
    raidcontroller_set = Set.new()
    mdstat = Facter::Util::Resolution.exec('cat /proc/mdstat 2>/dev/null')
    if mdstat != nil
      mdstat.each_line do |l|
        if l =~ /^md.*: .*raid/
          raidcontroller_set << 'linux-software-raid'
          break
        end
      end
    end
    setcode do
      lspci_adaptec = Facter::Util::Resolution.exec('lspci -d 9005: 2>/dev/null')
      raidcontroller_set << 'adaptec-raid' if lspci_adaptec != nil
      lspci_lsi = Facter::Util::Resolution.exec('lspci -d 1000: 2>/dev/null')
      if lspci_lsi != nil
        lspci_lsi.each_line do |l|
          if l.include?("Fusion-MPT Dual Ultra320") then
            raidcontroller_set << "lsi_mpt_fusion_u320"
          elsif l.include?("MegaRAID SAS") then
            raidcontroller_set << "lsi_megasas"
          elsif l.include?("SAS1078 PCI-X Fusion-MPT SAS") then
            raidcontroller_set << "lsi_megasas"
          elsif l.include?("MegaRAID") then
            raidcontroller_set << "lsi_megaraid"
          elsif l.include?("LSI MegaSAS") then
            raidcontroller_set << "lsi_megasas"
          end
        end
      end
      raidcontroller_set.to_a.join(',')
    end
  end
end
