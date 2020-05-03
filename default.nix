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
      epkgs.org-plus-contrib
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
  blog-deploy = pkgs.writeShellScriptBin "blog-deploy"
    ''
      echo "test" > test.txt
      ${pkgs.rsync}/bin/rsync -avz --delete -e "${pkgs.openssh}/bin/ssh -F /dev/null -o 'CheckHostIP no' -i /tmp/deploy_rsa" public/ andrea@cc0.tech:~/www/ 
    '';
in
stdenv.mkDerivation rec {
  name = "blog";

  buildInputs = [ blog-build blog-serve blog-deploy ];
}

