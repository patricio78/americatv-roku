sub Main()
    screen = CreateObject("roSGScreen") 'Create Screen object
    m.port = CreateObject("roMessagePort") 'Create Message port
    screen.setMessagePort(m.port) 'Set message port to listen to screen

    scene = screen.CreateScene("HomeScene") 'Create HomeScene
    screen.show()

    while(true) 'Listens to see if screen is closed
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub
