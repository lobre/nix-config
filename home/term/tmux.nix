{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    shortcut = "space";
    resizeAmount = 5;
    keyMode = "vi";
    historyLimit = 5000;
    escapeTime = 1;
    customPaneNavigationAndResize = false;
    clock24 = true;
    baseIndex = 1;
    
    # to manage sessions
    tmuxp.enable = true;

    extraConfig = ''
      setw -g pane-base-index 1

      # highlight window when it has new activity
      setw -g monitor-activity off
      set -g visual-activity off

      # enable ctrl + arrow moves
      set -g xterm-keys on

      # don't rename windows automatically
      set-option -g allow-rename off
      set-window-option -g automatic-rename off

      # mouse
      set -g mouse off
      bind m set -g mouse \; display "Mouse mode changed"

      # kill current pane
      bind q kill-pane

      # Default pane switching
      bind c select-pane -L
      bind t select-pane -D
      bind s select-pane -U
      bind r select-pane -R

      # Pane resize
      bind -r C resize-pane -L 5
      bind -r T resize-pane -D 5
      bind -r S resize-pane -U 5
      bind -r R resize-pane -R 5

      # window splitting
      bind / split-window -h
      bind - split-window -v

      # toggle synchronize mode
      bind a set-window-option synchronize-panes \; display "Synchronize mode changed"

      # restore ctrl + L to clear screen with prefix + Ctrl + L
      bind C-l send-keys 'C-l'

      bind w new-window
      bind W choose-window

      unbind [
      bind g copy-mode

      unbind P
      bind P paste-buffer

      bind -T copy-mode-vi v send -X begin-selection

      # Enter copy in clipboard
      bind -T copy-mode-vi Enter send -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
      bind -T copy-mode-vi y send -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

      bind -T copy-mode-vi C-v send -X rectangle-toggle
      bind -T copy-mode-vi Escape send -X cancel

      bind -T copy-mode-vi d send -X halfpage-down
      bind -T copy-mode-vi u send -X halfpage-up

      bind -T copy-mode-vi c send -X cursor-left
      bind -T copy-mode-vi t send -X cursor-down
      bind -T copy-mode-vi s send -X cursor-up
      bind -T copy-mode-vi r send -X cursor-right
      bind -T copy-mode-vi C send -X top-line
      bind -T copy-mode-vi R send -X bottom-line
      bind -T copy-mode-vi T send -X scroll-down
      bind -T copy-mode-vi S send -X scroll-up

      # Prevent garbage characters everywhere after copy
      set-option -s set-clipboard off

      # The status bar itself.
      set -g status-justify centre
      set -g status-left-length 40
      set -g status-left "#[fg=green]#H"
      set -g status-right "#[fg=blue]%d %b %R"

      # default statusbar colors
      set -g status-fg white
      set -g status-bg default
    '';
  };
}