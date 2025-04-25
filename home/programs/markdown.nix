{...}: {
  home.file.".config/markdown/.markdownlint-cli2.yaml" = {
    text = ''
      # https://github.com/DavidAnson/markdownlint/blob/v0.32.1/schema/.markdownlint.yaml
      config:
        MD013:
          line_length: 120
          code_blocks: false
        MD033: false
        MD041: false
    '';
  };
}
