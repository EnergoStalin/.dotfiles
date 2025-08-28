au BufWritePost suda:///etc/sing-box/* !sudo systemctl restart sing-box.service && journalctl -o cat -fu sing-box.service
au BufWritePost suda:///etc/docker/daemon.json !sudo systemctl restart docker.service && journalctl -o cat -fu docker.service
au BufWritePost suda:///etc/coredns/Corefile !sudo systemctl restart coredns.service && journalctl -o cat -fu coredns.service
au BufWritePost suda:///etc/yggdrasil.conf !sudo systemctl restart yggdrasil.service && journalctl -o cat -fu yggdrasil.service
au BufWritePost suda:///etc/nftables.conf silent !sudo nft -f /etc/nftables.conf

au BufWritePost suda:///etc/nginx/* !sudo systemctl restart nginx.service && journalctl -o cat -fu nginx.service

au BufWritePost suda:///etc/systemd/* silent !sudo systemctl daemon-reload

au BufWritePost */.local/share/wireplumber/scripts/*,*/.config/wireplumber/* !
      \ systemctl --user restart pipewire-session-manager.service &&
      \ journalctl -o cat --user -fu pipewire-session-manager.service

au BufWritePost ~/.config/systemd/* !systemctl --user daemon-reload
au BufWritePost ~/.config/gpu-screen-recorder.env !
      \ systemctl --user restart gpu-screen-recorder.service &&
      \ journalctl -o cat --user -fu gpu-screen-recorder.service