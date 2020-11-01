{
  enable = true;
  shellAliases = {
    ll = "ls -la --color=auto";
    ls = "ls --color=auto";
    vim = "nvim";
    hm = "home-manager";
  };
  initExtra = ''
    set -o vi
    PS1="\[\033[33m\]ﬦ: \[\033[36m\]\W\[\033[00m\]> "
  '';
}
