; Move the pointer to the center of a display by its Windows monitor number.
CapsLock & 1::HandleCapsLockNumber(2, 1)
CapsLock & 2::HandleCapsLockNumber(1, 2)
CapsLock & 3::HandleCapsLockNumber(3, 3)
CapsLock & 4::HandleCapsLockNumber(4, 4)

HandleCapsLockNumber(monitorNumber, desktopNumber) {
    if GetKeyState("Shift", "P") {
        desktopNames := ["WORK", "MY", "GM"]
        if desktopNumber <= desktopNames.Length {
            SwitchToDesktopByName(desktopNames[desktopNumber])
        }
        return
    }

    MovePointerToMonitorCenter(monitorNumber)
}

MovePointerToMonitorCenter(monitorNumber) {
    ; Use physical coordinates so displays with different DPI scales align correctly.
    previousDpiContext := DllCall(
        "User32.dll\SetThreadDpiAwarenessContext",
        "Ptr", -4,
        "Ptr"
    )

    try {
        MonitorGet(monitorNumber, &left, &top, &right, &bottom)
    } catch {
        MsgBox "Monitor " monitorNumber " was not found."
    } else {
        centerX := left + (right - left) // 2
        centerY := top + (bottom - top) // 2
        DllCall("User32.dll\SetCursorPos", "Int", centerX, "Int", centerY)
    } finally {
        if previousDpiContext {
            DllCall(
                "User32.dll\SetThreadDpiAwarenessContext",
                "Ptr", previousDpiContext,
                "Ptr"
            )
        }
    }
}
