function wait(n)
    n = tonumber(n) or 0.3
    local start = os.clock()
    repeat until (os.clock()-start) >= n
    return true
end






function start_server()
    wait(1)
    print("Hello!")
end

coroutine.wrap(start_server)()
