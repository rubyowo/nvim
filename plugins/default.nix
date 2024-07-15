{ pkgs }:
let
  srcs = builtins.mapAttrs (_: pkg: pkg.src) (pkgs.callPackage ../_sources/generated.nix { });
in
rec {
  config = {
    src = ../config;
    lazy = false;
    priority = 1000;
  };

  # tree view
  neo-tree = {
    src = srcs.neo-tree-nvim;
    event = "VeryLazy";
    config = {
      close_if_last_window = true;
      filesystem.hijack_netrw_behavior = "open_current";
    };
    dependencies = {
      inherit plenary nvim-web-devicons nui;
    };
  };

  alpha = {
    src = srcs.alpha-nvim;
    config = ./alpha.lua;
    dependencies = {
      neovim-session-manager = {
        src = srcs.neovim-session-manager;
        dependencies = {
          inherit plenary;
        };
      };
    };
  };

  lualine = {
    src = srcs.lualine;
    config = ./lualine.lua;
    dependencies = {
      navic = {
        src = srcs.nvim-navic;

        config = {
          highlight = true;
          separator = " ";
          icons = {
            File = " ";
            Module = " ";
            Namespace = " ";
            Package = " ";
            Class = " ";
            Method = " ";
            Property = " ";
            Field = " ";
            Constructor = " ";
            Enum = " ";
            Interface = " ";
            Function = " ";
            Variable = " ";
            Constant = " ";
            String = " ";
            Number = " ";
            Boolean = " ";
            Array = " ";
            Object = " ";
            Key = " ";
            Null = " ";
            EnumMember = " ";
            Struct = " ";
            Event = " ";
            Operator = " ";
            TypeParameter = " ";
          };
        };

        dependencies = {
          inherit nvim-web-devicons;
        };
      };
    };
  };

  catppuccin = {
    src = srcs.catppuccin;
    config = ./catppuccin.lua;
    priority = 1000;
  };

  fidget = {
    src = srcs.fidget;
    # event = "VeryLazy";
    lazy = false;

    config = {
      display.done_icon = "󰗡";
      notification = {
        override_vim_notify = true;
        window.winblend = 0;
      };
    };
  };

  nvim-colorizer = {
    src = srcs.nvim-colorizer-lua;
    event = "VeryLazy";

    config = {
      user_default_options = {
        RGB = true;
        RRGGBB = true;
        names = false;
        RRGGBBAA = true;
        AARRGGBB = true;
        rgb_fn = true;
        hsl_fn = true;
        css = true;
        css_fn = true;
        mode = "background";
        tailwind = "both";
        sass = {
          enable = true;
        };
        virtualtext = " ";
      };

      buftypes = [
        "*"
        "!dashboard"
        "!lazy"
        "!popup"
        "!prompt"
      ];
    };
  };

  todo-comments = {
    src = srcs.todo-comments;
    config = true;
    event = "VeryLazy";
  };

  # quicker movement
  telescope = {
    src = srcs.telescope;
    config = ./telescope.lua;
    dependencies = {
      inherit plenary nvim-web-devicons;
      telescope-fzf-native.package = pkgs.vimPlugins.telescope-fzf-native-nvim;
      telescope-ui-select.src = srcs.telescope-ui-select;
    };
  };

  harpoon = {
    src = srcs.harpoon;
    config = ./harpoon.lua;
    dependencies = {
      inherit plenary;
    };
  };

  # lsp
  nvim-treesitter = {
    config = ./tree-sitter.lua;
    event = "VeryLazy";
    dependencies.rainbow-delimiters.src = srcs.rainbow-delimiters;
    package = (pkgs.callPackage ../pkgs/nvim-treesitter { }).override {
      grammars = [
        "astro"
        "awk"
        "bash"
        "c"
        "cpp"
        "css"
        "csv"
        "diff"
        "dockerfile"
        "git_config"
        "git_rebase"
        "gitattributes"
        "gitcommit"
        "gitignore"
        "go"
        "gomod"
        "gosum"
        "gotmpl"
        "gpg"
        "graphql"
        "haskell"
        "html"
        "javascript"
        "jsdoc"
        "json"
        "jsonc"
        "just"
        "lua"
        "make"
        "markdown"
        "markdown_inline"
        "nix"
        "nu"
        "php"
        "php_only"
        "pug"
        "python"
        "rust"
        "scss"
        "svelte"
        "toml"
        "tsv"
        "tsx"
        "typescript"
        "vim"
        "vimdoc"
        "vue"
        "yaml"
        "yuck"
        "zig"
      ];
    };
  };

  # rust lsp + formmating
  rustaceanvim = {
    src = srcs.rustaceanvim;
    config = ./rust.lua;
    ft = "rust";
  };

  nvim-lspconfig = {
    src = srcs.nvim-lspconfig;
    config = ./lsp.lua;

    event = "VeryLazy";
    dependencies = {
      cmp.src = srcs.nvim-cmp;
      cmp-buffer.src = srcs.cmp-buffer;
      cmp-cmdline.src = srcs.cmp-cmdline;
      cmp-nvim-lsp.src = srcs.cmp-nvim-lsp;
      cmp-path.src = srcs.cmp-path;
      cmp_luasnip.src = srcs.cmp_luasnip;
      lspkind.src = srcs.lspkind;
      none-ls.src = srcs.none-ls;
      lsp-status.src = srcs.lsp-status;
      ltex-extra.src = srcs.ltex-extra;
      schemastore.src = srcs.schemastore;
      py_lsp.src = srcs.py_lsp;
      typescript-tools.src = srcs.typescript-tools;
      luasnip.src = srcs.luasnip;

      trouble = {
        src = srcs.trouble;
        config = ./trouble.lua;
      };

      lazydev-nvim = {
        src = srcs.lazydev-nvim;
        config = true;
      };

      crates = {
        src = srcs.crates;
        config = true;
        event = "BufRead Cargo.toml";
      };
    };
  };

  undotree = {
    src = srcs.undotree;
    config = ''
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    '';
  };

  indent-blankline = {
    src = srcs.indent-blankline;
    main = "ibl";
    config.exclude.filetypes = [
      "alpha"
      "fugitive"
      "help"
      "lazy"
      "NvimTree"
      "LazyGit"
      "TelescopePrompt"
      "prompt"
      "code-action-menu-menu"
      "code-action-menu-warning-message"
      "Trouble"
    ];
    event = "VeryLazy";
  };

  # lazygit integration
  lazygit = {
    src = srcs.lazygit;
    event = "VeryLazy";
    dependencies = {
      inherit plenary;
    };
    paths = [ pkgs.lazygit ];
  };

  # deps
  plenary.src = srcs.plenary;

  nvim-web-devicons = {
    src = srcs.nvim-web-devicons;
    config = ./nvim-web-devicons.lua;
    event = "VeryLazy";
  };

  nui.src = srcs.nui;
}
