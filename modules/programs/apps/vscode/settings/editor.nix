{ config }:
let
  fontSize = 15;
in {
  "diffEditor.ignoreTrimWhitespace" = true;
  "editor.bracketPairColorization.enabled" = true;
  "editor.detectIndentation" = false;
  "editor.formatOnSave" = true;
  "editor.fontFamily" = config.fontProfiles.monospace.family;
  "editor.fontSize" = fontSize;
  "editor.fontWeight" = "normal";
  "editor.guides.bracketPairs" = true;
  "editor.insertSpaces" = true;
  "editor.lineNumbers" = "relative";
  "editor.tabSize" = 2;
  "window.zoomLevel" = 0.5;
  "workbench.colorTheme" = "Catppuccin Mocha";
  "workbench.iconTheme" = "material-icon-theme";
  "terminal.integrated.fontSize" = fontSize;
  "terminal.integrated.scrollback" = 10000;
  "editor.minimap.enabled" = false;
  "editor.stickyScroll.enabled" = false;
}
