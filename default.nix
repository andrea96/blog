with import <nixpkgs> {
 overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
  ];
};

let
  customEmacs = (emacsWithPackagesFromUsePackage {
    config = builtins.readFile ./publish.el;
    package = pkgs.emacs;
    extraEmacsPackages = epkgs: [
      epkgs.htmlize
    ];
  });
  blog-build = pkgs.writeShellScriptBin "blog-build"
    ''
      rm -Rf public/
      ${customEmacs}/bin/emacs --batch --no-init --load publish.el --funcall org-publish-all        
    '';
  blog-serve = pkgs.writeShellScriptBin "blog-serve"
    ''
      ${pkgs.python3}/bin/python -m http.server --directory=public/ 8080
    '';
in
stdenv.mkDerivation rec {
  name = "blog";

  buildInputs = [ blog-build blog-serve ];
}

