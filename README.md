# AutoHotkey Configuration

Personal [AutoHotkey v2](https://www.autohotkey.com/) shortcuts for Windows 11.

## Keyboard shortcuts

All shortcuts are global: they work regardless of which application is active.

| Shortcut | Windows 11 action |
| --- | --- |
| `Ctrl` + `Alt` + `Q` | Close the active window, equivalent to `Alt` + `F4`. |
| `Ctrl` + `Alt` + `E` | Skip to the next media track. |
| `Ctrl` + `Alt` + `W` | Toggle media playback and pause. |
| `Ctrl` + `Alt` + `X` | Increase the system volume by one step. |
| `Ctrl` + `Alt` + `Z` | Decrease the system volume by one step. |
| `Ctrl` + `Alt` + `C` | Toggle system mute. |

## Mouse controls

`Caps Lock` is disabled and acts as a mouse-control layer modifier. These shortcuts can be combined with `Caps Lock` to control the pointer.

| Shortcut | Action |
| --- | --- |
| `CapsLock` + `Up` | Move up. |
| `CapsLock` + `Left` | Move left. |
| `CapsLock` + `Down` | Move down. |
| `CapsLock` + `Right` | Move right. |
| `CapsLock` + `W` | Middle-click. |
| `CapsLock` + `E` | Left-click. |
| `CapsLock` + `Q` | Right-click. |
| `CapsLock` + `F` | Double left-click. |
| `CapsLock` + `A` | Scroll up. |
| `CapsLock` + `D` | Scroll down. |

Hold two direction keys together to move diagonally. Holding a direction starts with one-pixel movement and gradually speeds up. Hold `Space` as well to enable the faster acceleration mode.

To drag, press `CapsLock` + `E` (or `Q`) twice and hold the second press. The left (or right) mouse button remains held until `E`/`Q` or `CapsLock` is released.

## Virtual desktop switching

| Shortcut | Action |
| --- | --- |
| `CapsLock` + `1` | Switch to the `WORK` virtual desktop. |
| `CapsLock` + `2` | Switch to the `MY` virtual desktop. |
| `CapsLock` + `3` | Switch to the `GM` virtual desktop. |

Switching uses the local `VirtualDesktopAccessor.dll` dependency to find desktops by name and switch to them directly. The DLL is from [Ciantic/VirtualDesktopAccessor](https://github.com/ciantic/VirtualDesktopAccessor) and is MIT-licensed; its license is included in `lib/LICENSE-VirtualDesktopAccessor.txt`.
