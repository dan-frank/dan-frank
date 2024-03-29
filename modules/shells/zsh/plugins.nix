# https://github.com/unixorn/awesome-zsh-plugins
{ pkgs }:
[
  {
    name = "powerlevel10k";
    file = "powerlevel10k.zsh-theme";
    src = pkgs.fetchFromGitHub {
      owner = "romkatv";
      repo = "powerlevel10k";
      rev = "v1.17.0";
      sha256 = "fgrwbWj6CcPoZ6GbCZ47HRUg8ZSJWOsa7aipEqYuE0Q=";
    };
  }
  {
    name = "zsh-you-should-use";
    file = "you-should-use.plugin.zsh";
    src = pkgs.fetchFromGitHub {
      owner = "MichaelAquilina";
      repo = "zsh-you-should-use";
      rev = "c062be916d0307fd851023c7afdbf7894b6667b6";
      sha256 = "uUQ8E7CcjgBMPhdP6iA/PI5X+4SUr+/FpTrxckiob9Q=";
    };
  }
  {
    name = "zsh-vi-mode";
    src = pkgs.fetchFromGitHub {
      owner = "jeffreytse";
      repo = "zsh-vi-mode";
      rev = "v0.9.0";
      sha256 = "KQ7UKudrpqUwI6gMluDTVN0qKpB15PI5P1YHHCBIlpg=";
    };
  }
  {
    name = "history-search-multi-word";
    src = pkgs.fetchFromGitHub {
      owner = "zdharma-continuum";
      repo = "history-search-multi-word";
      rev = "458e75c16db72596e4d7c6a45619dec285ebdcd7";
      sha256 = "6B8uoKJm3gWmufsnLJzLEdSm1tQasrs2fUmS0pDsdMw=";
    };
  }
  {
    name = "fast-syntax-highlighting";
    src = pkgs.fetchFromGitHub {
      owner = "zdharma-continuum";
      repo = "fast-syntax-highlighting";
      rev = "7c390ee3bfa8069b8519582399e0a67444e6ea61";
      sha256 = "wLpgkX53wzomHMEpymvWE86EJfxlIb3S8TPy74WOBD4=";
    };
  }
  {
    name = "zsh-autosuggestions";
    src = pkgs.fetchFromGitHub {
      owner = "zsh-users";
      repo = "zsh-autosuggestions";
      rev = "v0.6.3";
      sha256 = "1h8h2mz9wpjpymgl2p7pc146c1jgb3dggpvzwm9ln3in336wl95c";
    };
  }
  {
    name = "zsh-syntax-highlighting";
    src = pkgs.fetchFromGitHub {
      owner = "zsh-users";
      repo = "zsh-syntax-highlighting";
      rev = "be3882aeb054d01f6667facc31522e82f00b5e94";
      sha256 = "0w8x5ilpwx90s2s2y56vbzq92ircmrf0l5x8hz4g1nx3qzawv6af";
    };
  }
  {
    name = "zsh-completions";
    src = pkgs.fetchFromGitHub {
      owner = "zsh-users";
      repo = "zsh-completions";
      rev = "92dc417c3e818e9b526b2a574021361432b47282";
      sha256 = "NPDjyLAXdtZ8lrt7WLaeyJ3psboCHNJtPamC2fohzE8=";
    };
  }
  {
    name = "zsh-nix-shell";
    file = "nix-shell.plugin.zsh";
    src = pkgs.fetchFromGitHub {
      owner = "chisui";
      repo = "zsh-nix-shell";
      rev = "v0.5.0";
      sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
    };
  }
]
