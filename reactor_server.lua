function start_server()
    sleep(3)
    print("Hello!")
end

coroutine.wrap(start_server)()
