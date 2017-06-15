io.stdout:setvbuf 'line'

local user = ""
local audit_users = {
  <% @audit_users.each do |user| -%>
  ['<%= user %>'] = true,
  <% end -%>
}

function read_auth()
  local con = proxy.connection
  user = con.client.username
end

function connect_server()
  for i = 1, #proxy.global.backends do
    local s = proxy.global.backends[i]

    if s.state ~= proxy.BACKEND_STATE_DOWN then
      proxy.connection.backend_ndx = i
      return
    end
  end
end

function read_query(packet)
  if audit_users[user] and packet:byte() == proxy.COM_QUERY then
    print("[" .. user .. "] query: " .. packet:sub(2))
  end
  for i = 1, #proxy.global.backends do
    local s = proxy.global.backends[i]
    if s.state ~= proxy.BACKEND_STATE_DOWN then
      proxy.connection.backend_ndx = i
      return
    end
  end
end
