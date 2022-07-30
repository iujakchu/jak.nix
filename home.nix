{pkgs, ...}: {
  home.stateVersion = "22.05";
  home.packages = with pkgs; [
  ];
  programs = {
    zathura = {
      enable = true;
      options = {
      };
    };
    neovim = {
      enable = true;
      viAlias = true;
      package = pkgs.neovim-nightly;
    };
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
        ll = "exa -l --icons";
        la = "exa -al --icons";
        asd = "lazygit";
        update = "sudo nixos-rebuild --flake . switch ";
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
    };
  };
}
