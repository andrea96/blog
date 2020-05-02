with import <nixpkgs> {};

let
  blog-build = pkgs.writeShellScriptBin "blog-build"
    ''
      rm -Rf public/
      ${pkgs.emacs}/bin/emacs --batch --no-init --load publish.el --funcall org-publish-all        
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
