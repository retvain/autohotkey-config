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

## Monitor shortcuts

| Shortcut | Action |
| --- | --- |
| `CapsLock` + `1` | Move the pointer to the center of monitor 1. |
| `CapsLock` + `2` | Move the pointer to the center of monitor 2. |
| `CapsLock` + `3` | Move the pointer to the center of monitor 3. |
| `CapsLock` + `4` | Move the pointer to the center of monitor 4. |

Monitor numbers match the numbers shown by Windows Display settings. The pointer is placed using each display's physical coordinates, including mixed resolutions, orientations, and DPI scales.

## Virtual desktop switching

| Shortcut | Action |
| --- | --- |
| `CapsLock` + `Shift` + `1` | Switch to the `WORK` virtual desktop. |
| `CapsLock` + `Shift` + `2` | Switch to the `MY` virtual desktop. |
| `CapsLock` + `Shift` + `3` | Switch to the `GM` virtual desktop. |

Switching uses the local `VirtualDesktopAccessor.dll` dependency to find desktops by name and switch to them directly. The DLL is from [Ciantic/VirtualDesktopAccessor](https://github.com/ciantic/VirtualDesktopAccessor) and is MIT-licensed; its license is included in `lib/LICENSE-VirtualDesktopAccessor.txt`.

## Window controls

| Shortcut | Action |
| --- | --- |
| `Ctrl` + `Alt` + `D` | Minimize the active window. |
| `CapsLock` + `O` | Toggle maximize for the active window. |
