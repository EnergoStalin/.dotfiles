. ~/.profile

systemctl --user import-environment DISPLAY XAUTHORITY
systemctl start --user --wait i3-session.service
