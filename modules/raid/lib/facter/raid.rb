require 'set'

if Facter.value(:kernel) == "Linux"
  Facter.add("raid") do
    confine :kernel => :linux
    setcode do
      raid_list = Set.new()

      mdstat_output = `cat /proc/mdstat 2>/dev/null`
      if $?.success?
        mdstat_output.each_line do |l|
          if l =~ /^md.*: .*raid/
            raid_list << 'linux-md'
            break
          end
        end
      end

      lspci_adaptec_output = `lspci -d 9005: 2>/dev/null`
      if $?.success?
        raid_list << 'adaptec' if lspci_adaptec_output
      end

      lspci_lsi_output = `lspci -d 1000: 2>/dev/null`
      if $?.success?
        lspci_lsi_output.each_line do |l|
          raid_list << "lsi_mpt_fusion_u320" if l.include?("Fusion-MPT Dual Ultra320")
          raid_list << "lsi_megaraid" if l.include?("MegaRAID")
          raid_list << "lsi_megasas" if l.include?("MegaRAID SAS") || l.include?("SAS1078 PCI-X Fusion-MPT SAS") || l.include?("LSI MegaSAS")
        end
      end

      raid_list.to_a.join(',')
    end
  end
end
