Puppet::Type.type(:postgresql_psql).provide(:ruby) do

  def run_unless_sql_command(sql)
    # for the 'unless' queries, we wrap the user's query in a 'SELECT COUNT',
    # which makes it easier to parse and process the output.
    run_sql_command('SELECT COUNT(*) FROM (' << sql << ') count')
  end

  def run_sql_command(sql)
    command = ['psql']
    command.push("-d", resource[:db]) if resource[:db]
    command.push("-p", resource[:port]) if resource[:port]
    command.push("-t", "-c", '"' + sql.gsub('"', '\"') + '"')

    Dir.chdir '/tmp' do
      run_command(command, 'postgres', 'postgres')
    end
  end

  private

  def run_command(command, user, group)
    command = command.join ' '
    output = Puppet::Util::Execution.execute(command, {
      :uid => user,
      :gid => group,
      :failonfail => false,
      :combine => true,
      :override_locale => true,
    })
    [output, $CHILD_STATUS.dup]
  end

end
