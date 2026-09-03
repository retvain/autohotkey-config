; Caps Lock mouse-control layer.
SetCapsLockState "AlwaysOff"
mouseIsMoving := false
mouseStep := 2
mouseAccelerationTicks := 0
leftClickPending := false
rightClickPending := false
leftMouseHeld := false
rightMouseHeld := false
leftClickKeyDown := false
rightClickKeyDown := false
OnExit ReleaseMouseButtons

; Move the pointer with I/J/K/L, including diagonally.
; Hold Space to enable smooth acceleration.
CapsLock & i::StartMouseMove()
CapsLock & j::StartMouseMove()
CapsLock & k::StartMouseMove()
CapsLock & l::StartMouseMove()
CapsLock & w::Click("Middle")
CapsLock & e::HandleMouseButton("Left")
CapsLock & q::HandleMouseButton("Right")
CapsLock & a::Send "{WheelUp}"
CapsLock & d::Send "{WheelDown}"
CapsLock & Space::return
CapsLock & e Up::ReleaseMouseButtonKey("Left")
CapsLock & q Up::ReleaseMouseButtonKey("Right")
CapsLock Up::ReleaseCapsLockLayer()

StartMouseMove() {
    global mouseIsMoving, mouseStep, mouseAccelerationTicks

    if mouseIsMoving {
        return
    }

    mouseIsMoving := true
    mouseStep := 2
    mouseAccelerationTicks := 0

    SetTimer MoveMousePointer, 15
}

StopMouseMove() {
    global mouseIsMoving

    mouseIsMoving := false

    SetTimer MoveMousePointer, 0
}

MoveMousePointer() {
    global mouseStep, mouseAccelerationTicks

    if !GetKeyState("CapsLock", "P") {
        StopMouseMove()
        return
    }

    directionX := (GetKeyState("l", "P") ? 1 : 0) - (GetKeyState("j", "P") ? 1 : 0)
    directionY := (GetKeyState("k", "P") ? 1 : 0) - (GetKeyState("i", "P") ? 1 : 0)

    if directionX = 0 && directionY = 0 {
        StopMouseMove()
        return
    }

    distance := directionX && directionY ? Max(1, Round(mouseStep / Sqrt(2))) : mouseStep
    MouseMove(directionX * distance, directionY * distance, 0, "R")

    if !GetKeyState("Space", "P") {
        mouseStep := 2
        mouseAccelerationTicks := 0
        return
    }

    mouseAccelerationTicks += 1
    if Mod(mouseAccelerationTicks, 3) = 1 {
        mouseStep := Min(mouseStep + 1, 26)
    }
}

HandleMouseButton(button) {
    global leftClickPending, rightClickPending, leftClickKeyDown, rightClickKeyDown

    if button = "Left" {
        if leftClickKeyDown {
            return
        }

        leftClickKeyDown := true
        if leftClickPending {
            leftClickPending := false
            SetTimer SingleLeftClick, 0
            StartMouseCapture("Left")
        } else {
            leftClickPending := true
            SetTimer SingleLeftClick, -250
        }
    } else {
        if rightClickKeyDown {
            return
        }

        rightClickKeyDown := true
        if rightClickPending {
            rightClickPending := false
            SetTimer SingleRightClick, 0
            StartMouseCapture("Right")
        } else {
            rightClickPending := true
            SetTimer SingleRightClick, -250
        }
    }
}

ReleaseMouseButtonKey(button) {
    global leftClickKeyDown, rightClickKeyDown, leftMouseHeld, rightMouseHeld

    if button = "Left" {
        leftClickKeyDown := false
        if leftMouseHeld {
            leftMouseHeld := false
            Click("Left Up")
        }
    } else {
        rightClickKeyDown := false
        if rightMouseHeld {
            rightMouseHeld := false
            Click("Right Up")
        }
    }
}

SingleLeftClick() {
    global leftClickPending

    if leftClickPending {
        leftClickPending := false
        Click("Left")
    }
}

SingleRightClick() {
    global rightClickPending

    if rightClickPending {
        rightClickPending := false
        Click("Right")
    }
}

StartMouseCapture(button) {
    global leftMouseHeld, rightMouseHeld

    if button = "Left" {
        leftMouseHeld := true
        Click("Left Down")
    } else {
        rightMouseHeld := true
        Click("Right Down")
    }
}

ReleaseCapsLockLayer() {
    global leftClickKeyDown, rightClickKeyDown

    leftClickKeyDown := false
    rightClickKeyDown := false
    StopMouseMove()
    ReleaseMouseButtons()
}

ReleaseMouseButtons(*) {
    global leftMouseHeld, rightMouseHeld

    if leftMouseHeld {
        leftMouseHeld := false
        Click("Left Up")
    }

    if rightMouseHeld {
        rightMouseHeld := false
        Click("Right Up")
    }
}
