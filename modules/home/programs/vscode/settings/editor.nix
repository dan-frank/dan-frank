let
  font = {
    family = "'Terminus (TTF)', sans-serif";
    size = 15;
  };
in {
  "diffEditor.ignoreTrimWhitespace" = true;
  "editor.bracketPairColorization.enabled" = true;
  "editor.detectIndentation" = false;
  "editor.formatOnSave" = true;
  "editor.fontFamily" = font.family;
  "editor.fontSize" = font.size;
  "editor.fontWeight" = "normal";
  "editor.guides.bracketPairs" = true;
  "editor.insertSpaces" = true;
  "editor.lineNumbers" = "relative";
  "editor.tabSize" = 2;
  "window.zoomLevel" = 0.5;
  "workbench.colorTheme" = "GitHub Dark";
  "workbench.iconTheme" = "material-icon-theme";
  "terminal.integrated.fontSize" = font.size;
  "terminal.integrated.scrollback" = 10000;
}
