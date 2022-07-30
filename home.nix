{pkgs, ...}: {
  home.stateVersion = "22.05";
  home.packages = with pkgs; [
    neovim-nightly
    onefetch
    zathura
    alacritty
  ];
  xdg.configFile = {
    "nvim" = {
      source = ./xdg/nvim;
      recursive = true;
    };
    "hypr" = {
      source = ./xdg/hypr;
    };
    "alacritty" = {
      source = ./xdg/alacritty;
    };
  };
  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      oh-my-zsh = {
        enable = true;
        plugins = ["git" "sudo" "vi-mode"];
      };
      shellAliases = {
        ls = "exa --icons";
        vi = "nvim";
        ll = "exa -l --icons";
        l = "exa -al --icons";
        asd = "lazygit";
        update = "sudo nixos-rebuild --flake . switch --impure";
      };
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    git = {
      enable = true;
      userName = "iujakchu";
      userEmail = "iujakchu@163.com";
      extraConfig = {credential.helper = "store";};
    };
  };
}
