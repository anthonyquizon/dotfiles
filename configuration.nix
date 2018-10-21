{config, pkgs, ...}:
{
  environment.systemPackages = [
    git
    neovim
    silver-searcher
    nox
    tmux
    zsh
    oh-my-zsh
  ];

  services.openssh.enable = true;
}
