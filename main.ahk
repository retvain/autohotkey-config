#Requires AutoHotkey v2.0
#SingleInstance Force

; Закрывает активное окно так же, как Alt+F4.
^!q::Send "!{F4}"

; Управление мультимедиа.
^!e::Send "{Media_Next}"
^!w::Send "{Media_Play_Pause}"
^!x::Send "{Volume_Up}"
^!z::Send "{Volume_Down}"
^!c::Send "{Volume_Mute}"
