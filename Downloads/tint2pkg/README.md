# Tint2 as a detached tray area/bar

The basic idea behind this is to be able display the tray area only when you actually need to use a tray icon. The problem with i3 is that it doesn't handle well odd bar positions (e.g., sidebar). For example, if you try to change Tint2's positon to display it vertically on either side of the screen, you will encounter all kinds of odd behavior from i3. This is probably due to i3's interpretation of Xorg's `_NET_WM_WINDOW_TYPE_DOCK` property. Apparently, i3 assumes that a bar should only be placed horizontally taking up the whole width of the screen. That is why I had to patch Tint2 so that i3 will treat it like any normal window, thus allowing it to be placed and resized freely on the screen.

## Instructions

To install the patched Tint2, you should use the [Arch Build System](https://wiki.archlinux.org/index.php/Arch_Build_System), and have some familiarity with patching the source code.
