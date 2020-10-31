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
  '';
}
