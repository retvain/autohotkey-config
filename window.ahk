; Window controls.
^!d::WinMinimize("A")
CapsLock & r::MovePointerToActiveWindowCenter()
CapsLock & o::ToggleMaximize()

ActivateChatGPT() {
    windowHandle := FindChatGPTWindow()
    if windowHandle {
        if WinGetMinMax("ahk_id " windowHandle) = -1 {
            WinRestore("ahk_id " windowHandle)
        }
        WinActivate("ahk_id " windowHandle)
        return
    }

    ; Launch the installed Edge app identified in Windows by Get-StartApps.
    Run('explorer.exe shell:AppsFolder\chatgpt.com-DFCB3CE4_ch69rtgtz055j!App')
    deadline := A_TickCount + 10000
    while A_TickCount < deadline {
        windowHandle := FindChatGPTWindow()
        if windowHandle {
            WinActivate("ahk_id " windowHandle)
            return
        }
        Sleep(100)
    }
}

FindChatGPTWindow() {
    for windowHandle in WinGetList("ahk_exe msedge.exe") {
        if InStr(WinGetTitle("ahk_id " windowHandle), "ChatGPT") = 1 {
            return windowHandle
        }
    }
    return 0
}

MovePointerToActiveWindowCenter() {
    windowHandle := WinExist("A")
    if !windowHandle {
        return
    }

    ; Extended frame bounds are physical pixels, including on mixed-DPI displays.
    windowRect := Buffer(16, 0)
    result := DllCall(
        "Dwmapi.dll\DwmGetWindowAttribute",
        "Ptr", windowHandle,
        "UInt", 9,
        "Ptr", windowRect.Ptr,
        "UInt", windowRect.Size,
        "Int"
    )

    if result != 0 {
        WinGetPos(&left, &top, &width, &height, "ahk_id " windowHandle)
        right := left + width
        bottom := top + height
    } else {
        left := NumGet(windowRect, 0, "Int")
        top := NumGet(windowRect, 4, "Int")
        right := NumGet(windowRect, 8, "Int")
        bottom := NumGet(windowRect, 12, "Int")
    }

    centerX := left + (right - left) // 2
    centerY := top + (bottom - top) // 2
    DllCall("User32.dll\SetCursorPos", "Int", centerX, "Int", centerY)
}

ToggleMaximize() {
    windowHandle := WinExist("A")
    if WinGetMinMax(windowHandle) = 1 {
        WinRestore(windowHandle)
    } else {
        WinMaximize(windowHandle)
    }
}
