/*==============================================================================================*

  +-----+-----+-----+-----+-----+-----+-----+
  | █▀▀ | ▄▀█ | █▀▀ | █▀▀ | ▄▀█ | █▀▄ | █▀▀ |
  | █▄▄ | █▀█ | ▄▄█ | █▄▄ | █▀█ | █▄▀ | ██▄ |
  +-----+-----+-----+-----+-----+-----+-----+

  Description:    Cascade is a minimalstic and keyboard centered custom theme removing a lot of the
                  subjective clutter default Firefox comes with. This theme is highly inspired by the
                  stylistic choices of SimpleFox by Miguel Ávila. 🦊
                  https://github.com/migueravila/SimpleFox

  Author:         Andreas Grafen
                  (https://andreas.grafen.info)

  Repository:     https://github.com/andreasgrafen/cascade
                  Thank you Nick, Abdallah, Benyamin and Wael for all the great suggestions for improvements! ♡

                  Nick:     https://github.com/nicksundermeyer
                  Abdallah: https://github.com/HeiWiper
                  Benyamin: https://github.com/benyaminl
                  Wael:     https://github.com/wael444

                  If you're looking for a **mouse-friendly** clone please check out Waterfall.
                  https://github.com/crambaud/waterfall

*==============================================================================================*/

{ pkgs, ... }:
let
  mergeFiles = files: builtins.concatStringsSep " " (map builtins.readFile files);
in
mergeFiles [
  ./includes/cascade-config-mouse.css
  ./vars.css
  ./includes/cascade-colours.css
  ./includes/cascade-layout.css
  ./includes/cascade-responsive.css
  ./includes/cascade-floating-panel.css
  ./includes/cascade-nav-bar.css
  ./includes/cascade-tabs.css
]
