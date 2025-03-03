if trim(system('id -u')) == '0'
  au BufWritePost /etc/sing-box/config.json !systemctl restart sing-box.service && journalctl -fu sing-box.service
  au BufWritePost /etc/docker/daemon.json !systemctl restart docker.service && journalctl -fu docker.service
  au BufWritePost /etc/coredns/Corefile !systemctl restart coredns.service && journalctl -fu coredns.service
  au BufWritePost /etc/yggdrasil.conf !systemctl restart yggdrasil.service && journalctl -fu yggdrasil.service
  au BufWritePost /etc/nftables.conf !nft -f <afile>

  au BufWritePost /etc/nginx/* !systemctl restart nginx.service && journalctl -fu nginx.service

  au BufWritePost /etc/systemd/* !systemctl daemon-reload
endif

au BufWritePost ~/.config/systemd/* !systemctl --user daemon-reload
au BufWritePost ~/.config/gpu-screen-recorder.env !
      \ systemctl --user restart gpu-screen-recorder.service &&
      \ journalctl --user -fu gpu-screen-recorder.service
