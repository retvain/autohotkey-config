; Caps Lock mouse-control layer.
SetCapsLockState "AlwaysOff"
mouseIsMoving := false
mouseNormalStep := 1
mouseNormalHoldingStep := 4
mouseStep := mouseNormalStep
mouseMaximumStep := 31
mouseAccelerationStartStep := 3
mouseAccelerationTicks := 0
mouseNormalMoveTicks := 0
leftClickPending := false
rightClickPending := false
leftMouseHeld := false
rightMouseHeld := false
leftClickKeyDown := false
rightClickKeyDown := false
OnExit ReleaseMouseButtons

; Move the pointer with P/L/;/', including diagonally.
; Hold Space to enable smooth acceleration.
CapsLock & p::StartMouseMove()
CapsLock & l::StartMouseMove()
CapsLock & SC027::StartMouseMove()
CapsLock & SC028::StartMouseMove()
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
    global mouseIsMoving, mouseNormalStep, mouseStep, mouseAccelerationTicks, mouseNormalMoveTicks

    if mouseIsMoving {
        return
    }

    mouseIsMoving := true
    mouseStep := mouseNormalStep
    mouseAccelerationTicks := 0
    mouseNormalMoveTicks := 0

    SetTimer MoveMousePointer, 7
}

StopMouseMove() {
    global mouseIsMoving

    mouseIsMoving := false

    SetTimer MoveMousePointer, 0
}

MoveMousePointer() {
    global mouseNormalStep, mouseNormalHoldingStep, mouseStep, mouseMaximumStep, mouseAccelerationStartStep, mouseAccelerationTicks, mouseNormalMoveTicks

    if !GetKeyState("CapsLock", "P") {
        StopMouseMove()
        return
    }

    directionX := (GetKeyState("SC028", "P") ? 1 : 0) - (GetKeyState("l", "P") ? 1 : 0)
    directionY := (GetKeyState("SC027", "P") ? 1 : 0) - (GetKeyState("p", "P") ? 1 : 0)

    if directionX = 0 && directionY = 0 {
        StopMouseMove()
        return
    }

    isAccelerating := GetKeyState("Space", "P")
    if !isAccelerating {
        mouseStep := Min(
            mouseNormalStep + Floor(mouseNormalMoveTicks / 10),
            mouseNormalHoldingStep
        )
        mouseAccelerationTicks := 0
        mouseNormalMoveTicks += 1
    } else if mouseAccelerationTicks = 0 {
        mouseStep := mouseAccelerationStartStep
        mouseNormalMoveTicks := 0
    }

    distance := directionX && directionY ? Max(1, Round(mouseStep / Sqrt(2))) : mouseStep
    MouseMove(directionX * distance, directionY * distance, 0, "R")

    if !isAccelerating {
        return
    }

    mouseAccelerationTicks += 1
    if Mod(mouseAccelerationTicks, 4) = 1 {
        mouseStep := Min(mouseStep + 1, mouseMaximumStep)
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
