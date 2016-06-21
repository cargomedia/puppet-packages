Puppet::Type.newtype(:postgresql_psql) do

  newparam(:name) do
    desc "An arbitrary tag for your own reference; the name of the message."
    isnamevar
  end

  newproperty(:command) do
    desc 'The SQL command to execute via psql.'

    defaultto { @resource[:name] }

    # If needing to run the SQL command, return a fake value that will trigger
    # a sync, else return the expected SQL command so no sync takes place
    def retrieve
      if @resource.should_run_sql
        return :notrun
      else
        return self.should
      end
    end

    def sync
      output, status = provider.run_sql_command(value)
      self.fail("Error executing SQL; psql returned #{status}: '#{output}'") unless status == 0
    end
  end

  newparam(:unless) do
    desc "An optional SQL command to execute prior to the main :command; " +
        "this is generally intended to be used for idempotency, to check " +
        "for the existence of an object in the database to determine whether " +
        "or not the main SQL command needs to be executed at all."

    # Return true if a matching row is found
    def matches(value)
      output, status = provider.run_unless_sql_command(value)
      self.fail("Error evaluating 'unless' clause, returned #{status}: '#{output}'") unless status == 0

      result_count = output.strip.to_i
      self.debug("Found #{result_count} row(s) executing 'unless' clause")
      result_count > 0
    end
  end

  newparam(:onlyif) do
    desc "An optional SQL command to execute prior to the main :command; " +
        "this is generally intended to be used for idempotency, to check " +
        "for the existence of an object in the database to determine whether " +
        "or not the main SQL command needs to be executed at all."

    # Return true if a matching row is found
    def matches(value)
      output, status = provider.run_unless_sql_command(value)
      status = output.exitcode if status.nil?

      self.fail("Error evaluating 'onlyif' clause, returned #{status}: '#{output}'") unless status == 0

      result_count = output.strip.to_i
      self.debug("Found #{result_count} row(s) executing 'onlyif' clause")
      result_count > 0
    end
  end

  newparam(:db) do
    desc "The name of the database to execute the SQL command against, this overrides any PGDATABASE value in connect_settings"
  end

  newparam(:port) do
    desc "The port of the database server to execute the SQL command against, this overrides any PGPORT value in connect_settings."
  end

  newparam(:refreshonly, :boolean => true) do
    desc "If 'true', then the SQL will only be executed via a notify/subscribe event."

    defaultto(:false)
    newvalues(:true, :false)
  end

  def should_run_sql(refreshing = false)
    onlyif_param = @parameters[:onlyif]
    unless_param = @parameters[:unless]
    return false if !onlyif_param.nil? && !onlyif_param.value.nil? && !onlyif_param.matches(onlyif_param.value)
    return false if !unless_param.nil? && !unless_param.value.nil? && unless_param.matches(unless_param.value)
    return false if !refreshing && @parameters[:refreshonly].value == :true
    true
  end

  def refresh
    self.property(:command).sync if self.should_run_sql(true)
  end

end
