{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;

    sessionVariables = {
      LAB = "$HOME/Lab";
      VISUAL = "vim";
      EDITOR = "vim";
    };

    shellAliases = {
      "ll"     = "ls -lh";
      "llt"    = "ll -rt";
      "lla"    = "ll -a";
      ".."     = "cd ..";
      "..."    = "cd ../..";
      "extip"  = "wget http://ipinfo.io/ip -qO -";
      "dl"     = "cd $HOME/Downloads && llt";
      "doc"    = "cd $HOME/Documents";
      "lab"    = "cd $HOME/Lab";
      "copy"   = "xclip -selection clipboard";
      "sshh"   = "sed -rn 's/^\s*Host\s+(.*)\s*/\1/ip' ~/.ssh/config";
      "rg"     = "rg --no-ignore-vcs --smart-case";
    };

    initExtra = ''
      # Use xterm terminal colors
      export TERM='xterm-256color'

      # Include unversioned files
      if [ -f "$HOME/.bashrc.local" ]; then
         . $HOME/.bashrc.local
      fi

      # Tcpdump clean
      function httpdump() {
          export port=80
          if [[ -n "$1" ]]; then
              export port=$1
          fi
          sudo -E stdbuf -oL -eL /usr/sbin/tcpdump -A -s 10240 "tcp port $port and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)" | egrep -a --line-buffered ".+(GET |HTTP\/|POST )|^[A-Za-z0-9-]+: " | perl -nle "BEGIN{$|=1} { s/.*?(GET |HTTP\/[0-9.]* |POST )/\n$port/g; print }"
      }

      # Certificate aliases
      function cert() { openssl s_client -showcerts -servername $1 -connect $1:443 < /dev/null 2>&1; }
      function certexpiration() { cert $1 | openssl x509 -dates -noout; }
      function certlist() { awk -v cmd='openssl x509 -noout -subject' ' /BEGIN/{close(cmd)};{print | cmd}' < /etc/ssl/certs/ca-certificates.crt; }
      function certfile() { openssl x509 -in $1 -text -noout; }

      # Usage
      # certgen maindomain.local
      # certgen maindomain.local DNS:othername.local
      # certgen maindomain.local DNS:othername.local,IP:127.0.0.1
      function certgen() {
          local san=""
          if [[ -n "$2" ]]; then
              san=",$2"
          fi
          openssl req \
              -x509 \
              -newkey rsa:4096 \
              -sha256 \
              -days 3650 \
              -nodes \
              -keyout "$1.key" \
              -out "$1.crt" \
              -extensions san \
              -config <(echo "[req]"; echo distinguished_name=req; echo "[san]"; echo "subjectAltName=DNS:$1$san") \
              -subj "/CN=$1"
      }

      # Strip comments
      function nocomments() {
          local char=#
          if [[ -n "$1" ]]; then
              char=$1
          fi
          sed "/^\s*$/d;/^$char/d"
      }
    '';
  };
}
