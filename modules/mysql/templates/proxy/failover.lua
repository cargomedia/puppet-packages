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
  for i = 1, #proxy.global.backends do
    local s = proxy.global.backends[i]

    if s.state ~= proxy.BACKEND_STATE_DOWN then
      proxy.connection.backend_ndx = i
      return
    end
  end
end
