{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      asvetliakov.vscode-neovim
      golang.go
      ms-vsliveshare.vsliveshare
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "material-theme";
        publisher = "zhuangtongfa";
        version = "3.13.2";
        sha256 = "1pb96xdm8342i1l4xp7wdbpfv353pjf6l0c3xkgw0lgfzvd0xshy";
      }
    ];

    userSettings = {
      "update.mode" = "none";

      # Better defaults
      "diffEditor.ignoreTrimWhitespace" = false;
      "diffEditor.renderSideBySide" = false;
      "editor.copyWithSyntaxHighlighting" = false;
      "editor.detectIndentation" = false;
      "editor.emptySelectionClipboard" = false;
      "editor.multiCursorModifier" = "ctrlCmd";
      "files.trimTrailingWhitespace" = true;
      "window.newWindowDimensions" = "inherit";
      "workbench.editor.enablePreview" = false;

      # Hide everything
      "editor.lineNumbers" = "off";
      "editor.minimap.enabled" = false;
      "editor.renderIndentGuides" = false;
      "window.menuBarVisibility" = "hidden";
      "workbench.activityBar.visible" = false;
      "workbench.sideBar.location" = "right";

      # Silence the noise
      "breadcrumbs.enabled" = false;
      "editor.colorDecorators" = false;
      "editor.gotoLocation.multipleDeclarations" = "goto";
      "editor.gotoLocation.multipleDefinitions" = "goto";
      "editor.gotoLocation.multipleImplementations" = "goto";
      "editor.gotoLocation.multipleReferences" = "goto";
      "editor.gotoLocation.multipleTypeDefinitions" = "goto";
      "editor.hideCursorInOverviewRuler" = true;
      "editor.hover.enabled" = false;
      "editor.lightbulb.enabled" = false;
      "editor.matchBrackets" = "never";
      "editor.occurrencesHighlight" = false;
      "editor.overviewRulerBorder" = false;
      "editor.renderControlCharacters" = false;
      "editor.renderLineHighlight" = "none";
      "editor.selectionHighlight" = false;
      "git.decorations.enabled" = false;
      "problems.decorations.enabled" = false;
      "scm.diffDecorations" = "none";
      "workbench.editor.enablePreviewFromQuickOpen" = false;
      "workbench.startupEditor" = "none";
      "workbench.tips.enabled" = false;

      # Typography
      "editor.fontFamily" = "MonoLisa";
      "editor.fontSize" = 14;
      "editor.fontWeight" = "400";
      "editor.fontLigatures" = "'calt' on, 'liga' on, 'ss02' on";
      "editor.lineHeight" = 30;
      "editor.suggestFontSize" = 14;
      "editor.suggestLineHeight" = 28;
      "terminal.integrated.fontSize" = 14;
      "terminal.integrated.lineHeight" = 1.5;
      "workbench.colorTheme" = "One Dark Pro Darker";

      # Colors
      "workbench.colorCustomizations" = {
        "editorCursor.foreground" = "#e7ebed";
        "editorCursor.background" = "#000000";
        "terminal.ansiBlack" = "#243137";
        "terminal.ansiRed" = "#fc3841";
        "terminal.ansiGreen" = "#5cf19e";
        "terminal.ansiYellow" = "#fed032";
        "terminal.ansiBlue" = "#37b6ff";
        "terminal.ansiMagenta" = "#fc226e";
        "terminal.ansiCyan" = "#59ffd1";
        "terminal.ansiWhite" = "#ffffff";
        "terminal.ansiBrightBlack" = "#84A6B8";
        "terminal.ansiBrightRed" = "#fc746d";
        "terminal.ansiBrightGreen" = "#adf7be";
        "terminal.ansiBrightYellow" = "#fee16c";
        "terminal.ansiBrightBlue" = "#70cfff";
        "terminal.ansiBrightMagenta" = "#fc669b";
        "terminal.ansiBrightCyan" = "#9affe6";
        "terminal.ansiBrightWhite" = "#ffffff";
      };

      # Neovim
      "vscode-neovim.neovimExecutablePaths.linux" = "${config.programs.neovim.package}/bin/nvim";

      # Go tooling
      "go.toolsManagement.checkForUpdates" = "off";
      "go.alternateTools" = {
        "gopls" = "${pkgs.gopls}/bin/gopls"; 
      };
    };

    keybindings = [
      # Terminal
      {
        key = "ctrl+t";
        command = "workbench.action.terminal.toggleTerminal";
      }

      # File explorer
      {
        key = "ctrl+n";
        command = "explorer.newFile";
        when = "explorerViewletVisible && filesExplorerFocus && !inputFocus";
      }
      {
        key = "ctrl+shift+n";
        command = "explorer.newFolder";
        when = "explorerViewletVisible && filesExplorerFocus && !inputFocus";
      }

      # Bring normal search back
      {
        key = "ctrl+f";
        command = "-vscode-neovim.ctrl-f";
        when = "editorTextFocus && neovim.ctrlKeysNormal && neovim.init && neovim.mode != 'insert'";
      }
    ];
  };
}