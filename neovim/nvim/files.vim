if trim(system('id -u')) == '0'
  au BufWritePost /etc/sing-box/* !systemctl restart sing-box.service && journalctl -o cat -fu sing-box.service
  au BufWritePost /etc/docker/daemon.json !systemctl restart docker.service && journalctl -o cat -fu docker.service
  au BufWritePost /etc/coredns/Corefile !systemctl restart coredns.service && journalctl -o cat -fu coredns.service
  au BufWritePost /etc/yggdrasil.conf !systemctl restart yggdrasil.service && journalctl -o cat -fu yggdrasil.service
  au BufWritePost /etc/nftables.conf !nft -f <afile>

  au BufWritePost /etc/nginx/* !systemctl restart nginx.service && journalctl -o cat -fu nginx.service

  au BufWritePost /etc/systemd/* !systemctl daemon-reload
endif

au BufWritePost */.local/share/wireplumber/scripts/*,*/.config/wireplumber/* !
      \ systemctl --user restart pipewire-session-manager.service &&
      \ journalctl -o cat --user -fu pipewire-session-manager.service

au BufWritePost ~/.config/systemd/* !systemctl --user daemon-reload
au BufWritePost ~/.config/gpu-screen-recorder.env !
      \ systemctl --user restart gpu-screen-recorder.service &&
      \ journalctl -o cat --user -fu gpu-screen-recorder.service
