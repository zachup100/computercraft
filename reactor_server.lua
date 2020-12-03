function start_server()
    os.sleep(3)
    print("Hello!")
end

coroutine.wrap(start_server)()
