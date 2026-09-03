#Requires AutoHotkey v2.0
#SingleInstance Force

#Include mouse.ahk

; Closes the active window, equivalent to Alt+F4.
^!q::Send "!{F4}"

; Media controls.
^!e::Send "{Media_Next}"
^!w::Send "{Media_Play_Pause}"
^!x::Send "{Volume_Up}"
^!z::Send "{Volume_Down}"
^!c::Send "{Volume_Mute}"
