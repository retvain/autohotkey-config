; Window controls.
^!d::WinMinimize("A")
CapsLock & o::ToggleMaximize()

ToggleMaximize() {
    windowHandle := WinExist("A")
    if WinGetMinMax(windowHandle) = 1 {
        WinRestore(windowHandle)
    } else {
        WinMaximize(windowHandle)
    }
}
