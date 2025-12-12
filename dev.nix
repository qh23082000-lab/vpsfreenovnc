{ pkgs, ... }: {
  channel = "stable-24.11";

  packages = [
    pkgs.docker
    pkgs.cloudflared
    pkgs.socat
    pkgs.netcat
    pkgs.curl
    pkgs.wget
  ];

  services.docker.enable = true;

  idx.workspace.onStart = {
    start-vps = ''
      if [ -f ~/vps/start-vps.sh ]; then
        chmod +x ~/vps/start-vps.sh
        bash ~/vps/start-vps.sh
      else
        echo "⚠️  Không tìm thấy start-vps.sh"
      fi
    '';
  };

  idx.previews = {
    enable = true;
    previews = {
      novnc = {
        manager = "web";
        command = [
          "bash" "-c"
          "socat TCP-LISTEN:$PORT,fork,reuseaddr TCP:127.0.0.1:10000"
        ];
      };
    };
  };
}
