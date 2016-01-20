require 'set'

if Facter.value(:kernel) == 'Linux'
  Facter.add('raid') do
    confine :kernel => :linux
    setcode do
      raid_list = Set.new()

      mdstat_output = `cat /proc/mdstat 2>/dev/null`
      if $?.success?
        mdstat_output.each_line do |l|
          if l =~ /^md.*: .*raid/
            raid_list << 'linux_md'
            break
          end
        end
      end

      lspci_adaptec_output = `lspci -d 9005: 2>/dev/null | grep 'RAID'`
      if $?.success?
        raid_list << 'adaptec' if lspci_adaptec_output
      end

      lspci_hp_output = `lspci -d 103c: 2>/dev/null | grep -E 'RAID bus controller.+Smart Array'`
      if $?.success?
        raid_list << 'hpssacli' if lspci_hp_output
      end

      lspci_lsi_output = `lspci -d 1000: 2>/dev/null | grep -E 'RAID|SCSI'`
      if $?.success?
        lspci_lsi_output.each_line do |l|
          raid_list << 'lsi_megaraidsas' if l.include?('MegaRAID SAS') || l.include?('SAS1078 PCI-X Fusion-MPT SAS') || l.include?('LSI MegaSAS')
          raid_list << 'sas2ircu' if l.include?('SAS2008 PCI-Express Fusion-MPT SAS-2')
        end
      end

      raid_list.to_a.join(',')
    end
  end
end
