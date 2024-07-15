{
  config.perSystem =
    {
      lib,
      pkgs,
      # inputs',
      ...
    }:
    {
      neovim = {
        # package = inputs'.neovim-nightly-overlay.packages.default;
        package = pkgs.neovim-unwrapped;

        paths = with pkgs; [
          # external deps
          fd
          git
          gh
          ripgrep

          # python
          ruff
          pyright
          black
          isort

          # lua
          stylua
          lua-language-server
          luaPackages.tl
          luaPackages.teal-language-server

          # node/webdev
          deno
          emmet-language-server
          vue-language-server
          nodePackages.nodejs
          nodePackages."@astrojs/language-server"
          nodePackages."@tailwindcss/language-server"
          nodePackages.graphql
          nodePackages.graphql-language-service-cli
          nodePackages.intelephense
          nodePackages.typescript
          nodePackages.typescript-language-server
          nodePackages.vscode-langservers-extracted

          # markdown / latex
          ltex-ls
          nodePackages.alex
          marksman

          # nix
          nil
          statix
          deadnix
          nixfmt-rfc-style

          # shell
          shfmt
          shellcheck
          bash-language-server

          # etc
          emmet-ls
          nodePackages.prettier
          proselint
          jq-lsp # json
          taplo # toml
          nodePackages.yaml-language-server # yaml
          haskell-language-server
          nodePackages.dockerfile-language-server-nodejs
        ];

        build =
          let
            env = pkgs.buildEnv {
              name = "neovim-host-prog";
              paths = [ pkgs.nodePackages.neovim ] ++ [ (pkgs.python3.withPackages (ps: with ps; [ pynvim ])) ];
            };
          in
          lib.mkForce {
            before = pkgs.writeTextFile {
              name = "before.lua";
              text = ''
                -- set space as leader
                vim.g.mapleader = " "
                vim.g.maplocalleader = " "

                -- this defaults to this and we want to keep it that way
                vim.g.node_host_prog = "${env}/bin/neovim-node-host"
                vim.g.python3_host_prog = "${env}/bin/python"
              '';
            };
          };

        lazy = {
          settings.dev.path = "~/configs/nvim";
          plugins = import ./plugins { inherit pkgs; };
        };
      };
    };
}
