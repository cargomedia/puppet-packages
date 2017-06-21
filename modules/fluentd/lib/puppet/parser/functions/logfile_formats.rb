module Puppet::Parser::Functions
  newfunction(:logfile_formats, :type => :rvalue, :doc => <<-EOS
    Return in_tail format options, with multiline support
  EOS
  ) do |args|
    format = args[0]
    format_firstline = args[1] || ''
    formats = args[2] || []

    if format.eql? 'multiline'
      {
        :format => 'multiline',
        :format_firstline => format_firstline,
      } + Hash[
        formats.map do |index, val|
          count = index + 1
          ["format#{count}", val]
        end
      ]
    else
      Hash[
        :format => format,
      ]
    end
  end
end
