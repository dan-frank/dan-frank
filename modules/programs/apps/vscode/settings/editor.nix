{ config }:
let
  fontSize = 15;
in {
  "diffEditor.ignoreTrimWhitespace" = true;
  "editor.formatOnSave" = true;
  "editor.formatOnPaste" = false;

  "editor.detectIndentation" = false;

  # "workbench.list.smoothScrolling" = true;
  # "editor.smoothScrolling" = true;
  # "editor.cursorSmoothCaretAnimation" = "on";

  "editor.lineNumbers" = "relative";
  "editor.minimap.enabled" = false;
  "editor.stickyScroll.enabled" = false;
  "window.zoomLevel" = 0.5;
  "editor.wordWrap" = "on";
  "editor.cursorBlinking" = "phase";

  "editor.bracketPairColorization.enabled" = true;
  "editor.guides.bracketPairs" = true;
  "editor.guides.indentation" = true;
  "editor.guides.highlightActiveIndentation" = true;

  "editor.insertSpaces" = true;
  "editor.tabSize" = 2;

  "editor.fontFamily" = config.fontProfiles.monospace.family;
  "editor.fontSize" = fontSize;
  "editor.fontWeight" = "normal";
  "editor.lineHeight" = 1.6;
  "editor.fontLigatures" = true;
}
