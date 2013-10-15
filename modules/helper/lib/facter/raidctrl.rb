Facter.add("raidctrl") do
  confine :kernel => :linux
  setcode do
    ENV["PATH"]="/bin:/sbin:/usr/bin:/usr/sbin"
    raidctrl_name = "none"
    system "which lspci >/dev/null"
    if $?.exitstatus == 0

      #LSI
      #http://hwraid.le-vert.net/wiki/LSI
      check_lsi = %x{lspci -d '1000:' 2>/dev/null}.to_s
      if check_lsi.include?("Fusion-MPT Dual Ultra320") then
        raidctrl_name = "lsi_mpt_fusion_u320"
      elsif check_lsi.include?("MegaRAID SAS") then
        raidctrl_name = "lsi_megasas"
      elsif check_lsi.include?("SAS1078 PCI-X Fusion-MPT SAS") then
        raidctrl_name = "lsi_megasas"
      elsif check_lsi.include?("MegaRAID") then
        raidctrl_name = "lsi_megaraid"
      elsif check_lsi.include?("LSI MegaSAS") then
        raidctrl_name = "lsi_megasas"
      end

      # linux software raid
      check_linuxmd = ((%x{cat /proc/mdstat 2>/dev/null}.to_s =~ /^md.*: .*raid/m) != nil)
      if check_linuxmd then
        raidctrl_name = "linuxmd"
      end

      # Adaptec
      check_adaptec = %x{lspci -d '9005:' 2>/dev/null}.to_s
      if check_adaptec.include?("Adaptec AAC-RAID") then
        raidctrl_name = "adaptec_aac"
      end

    end

    result = raidctrl_name
  end

end
