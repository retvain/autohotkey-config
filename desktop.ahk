; Virtual desktop shortcuts powered by VirtualDesktopAccessor.dll.
virtualDesktopAccessorDll := A_ScriptDir "\lib\VirtualDesktopAccessor.dll"

CapsLock & 1::SwitchToDesktopByName("WORK")
CapsLock & 2::SwitchToDesktopByName("MY")
CapsLock & 3::SwitchToDesktopByName("GM")

SwitchToDesktopByName(desktopName) {
    global virtualDesktopAccessorDll

    desktopCount := DllCall(virtualDesktopAccessorDll "\GetDesktopCount", "Int")
    if desktopCount < 1 {
        throw Error("VirtualDesktopAccessor could not read the virtual desktops.")
    }

    Loop desktopCount {
        desktopNumber := A_Index - 1
        if StrUpper(GetDesktopName(desktopNumber)) = StrUpper(desktopName) {
            result := DllCall(
                virtualDesktopAccessorDll "\GoToDesktopNumber",
                "Int", desktopNumber,
                "Int"
            )

            if result = -1 {
                throw Error("VirtualDesktopAccessor could not switch desktops.")
            }

            return
        }
    }

    MsgBox "Virtual desktop '" desktopName "' was not found."
}

GetDesktopName(desktopNumber) {
    global virtualDesktopAccessorDll

    nameBuffer := Buffer(1024, 0)
    result := DllCall(
        virtualDesktopAccessorDll "\GetDesktopName",
        "Int", desktopNumber,
        "Ptr", nameBuffer.Ptr,
        "UPtr", nameBuffer.Size,
        "Int"
    )

    if result = -1 {
        throw Error("VirtualDesktopAccessor could not read a desktop name.")
    }

    return StrGet(nameBuffer.Ptr, nameBuffer.Size, "UTF-8")
}
