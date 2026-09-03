; Caps Lock mouse-control layer.
SetCapsLockState "AlwaysOff"
mouseIsMoving := false
mouseNormalStep := 1
mouseNormalHoldingStep := 4
mouseStep := mouseNormalStep
mouseMaximumStep := 29
mouseAccelerationStartStep := 6
mouseAccelerationMode := false
mouseSpeedAdjustmentTicks := 0
mouseNormalMoveTicks := 0
leftClickPending := false
rightClickPending := false
leftMouseHeld := false
rightMouseHeld := false
leftClickKeyDown := false
rightClickKeyDown := false
OnExit ReleaseMouseButtons

; Move the pointer with arrow keys, including diagonally.
; Hold Space to enable smooth acceleration; release it to decelerate smoothly.
CapsLock & Up::StartMouseMove()
CapsLock & Left::StartMouseMove()
CapsLock & Down::StartMouseMove()
CapsLock & Right::StartMouseMove()
CapsLock & w::Click("Middle")
CapsLock & e::HandleMouseButton("Left")
CapsLock & q::HandleMouseButton("Right")
CapsLock & f::DoubleClick()
CapsLock & a::Send "{WheelUp}"
CapsLock & d::Send "{WheelDown}"
CapsLock & Space::return
CapsLock & e Up::ReleaseMouseButtonKey("Left")
CapsLock & q Up::ReleaseMouseButtonKey("Right")
CapsLock Up::ReleaseCapsLockLayer()

StartMouseMove() {
    global mouseIsMoving, mouseNormalStep, mouseStep, mouseAccelerationMode, mouseSpeedAdjustmentTicks, mouseNormalMoveTicks

    if mouseIsMoving {
        return
    }

    mouseIsMoving := true
    mouseStep := mouseNormalStep
    mouseAccelerationMode := false
    mouseSpeedAdjustmentTicks := 0
    mouseNormalMoveTicks := 0

    SetTimer MoveMousePointer, 7
}

StopMouseMove() {
    global mouseIsMoving

    mouseIsMoving := false

    SetTimer MoveMousePointer, 0
}

MoveMousePointer() {
    global mouseNormalStep, mouseNormalHoldingStep, mouseStep, mouseMaximumStep, mouseAccelerationStartStep, mouseAccelerationMode, mouseSpeedAdjustmentTicks, mouseNormalMoveTicks

    if !GetKeyState("CapsLock", "P") {
        StopMouseMove()
        return
    }

    directionX := (GetKeyState("Right", "P") ? 1 : 0) - (GetKeyState("Left", "P") ? 1 : 0)
    directionY := (GetKeyState("Down", "P") ? 1 : 0) - (GetKeyState("Up", "P") ? 1 : 0)

    if directionX = 0 && directionY = 0 {
        StopMouseMove()
        return
    }

    isAccelerating := GetKeyState("Space", "P")
    if isAccelerating != mouseAccelerationMode {
        mouseAccelerationMode := isAccelerating
        mouseSpeedAdjustmentTicks := 0

        if isAccelerating {
            mouseStep := Max(mouseStep, mouseAccelerationStartStep)
        }
    }

    normalTargetStep := 0
    if !isAccelerating {
        normalTargetStep := Min(
            mouseNormalStep + Floor(mouseNormalMoveTicks / 10),
            mouseNormalHoldingStep
        )
        mouseNormalMoveTicks += 1
        if mouseStep < normalTargetStep {
            mouseStep := normalTargetStep
            mouseSpeedAdjustmentTicks := 0
        }
    } else {
        mouseNormalMoveTicks := 0
    }

    distance := directionX && directionY ? Max(1, Round(mouseStep / Sqrt(2))) : mouseStep
    MouseMove(directionX * distance, directionY * distance, 0, "R")

    mouseSpeedAdjustmentTicks += 1
    if isAccelerating && Mod(mouseSpeedAdjustmentTicks, 3) = 1 {
        mouseStep := Min(mouseStep + 1, mouseMaximumStep)
    } else if !isAccelerating && mouseStep > normalTargetStep && Mod(mouseSpeedAdjustmentTicks, 2) = 1 {
        mouseStep := Max(mouseStep - 1, normalTargetStep)
    }
}

DoubleClick() {
    Click("Left")
    Click("Left")
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
