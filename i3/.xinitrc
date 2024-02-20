export GTK_THEME=Adwaita:dark
export XCURSOR_SIZE=24

dbus-update-activation-environment --systemd DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE
pw-link NullSink:monitor_FL VirtualMic:input_FL && pw-link NullSink:monitor_FR VirtualMic:input_FR

exec i3
