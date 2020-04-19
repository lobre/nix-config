{ config, pkgs, ... }:

{
  xdg.configFile."oni2/configuration.json".text = ''
    {
      "workbench.colorTheme": "One Dark Pro",
      "editor.detectIndentation": true,
      "editor.fontFamily": "FiraCode-Regular.ttf",
      "editor.fontSize": 14,
      "editor.largeFileOptimizations": true,
      "editor.highlightActiveIndentGuide": true,
      "editor.indentSize": 4,
      "editor.insertSpaces": false,
      "editor.lineNumbers": "on",
      "editor.matchBrackets": true,
      "editor.minimap.enabled": true,
      "editor.minimap.maxColumn": 120,
      "editor.minimap.showSlider": true,
      "editor.renderIndentGuides": true,
      "editor.renderWhitespace": "all",
      "editor.rulers": [],
      "editor.tabSize": 4,
      "editor.zenMode.hideTabs": true,
      "editor.zenMode.singleFile": true,
      "files.exclude": [ "_esy", "node_modules" ],
      "workbench.activityBar.visible": true,
      "workbench.editor.showTabs": true,
      "workbench.iconTheme": "vs-seti",
      "workbench.sideBar.visible": true,
      "workbench.statusBar.visible": true,
      "workbench.tree.indent": 2,
      "vim.useSystemClipboard": [ "yank" ],
      "experimental.viml": [] 
    }
  '';
}
