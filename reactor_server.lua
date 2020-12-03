function start_server()
    print("Hello!")
end

coroutine.wrap(start_server)()
