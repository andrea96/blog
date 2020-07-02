with import <nixpkgs> {
 overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
  ];
};

let
  customEmacs = (emacsWithPackagesFromUsePackage {
    config = "";
    package = pkgs.emacsUnstable;
    extraEmacsPackages = epkgs: [
      epkgs.org-static-blog
    ];
  });  
  customPython = python3.withPackages (ps: with ps; [
    htmlmin
    csscompressor
    rjsmin
    pillow
  ]); 
  blog-build = pkgs.writeShellScriptBin "blog-build"
    ''
      [ ! $CI ] && rm -Rf public/ ~/.org-timestamps/
      ${customEmacs}/bin/emacs --batch --no-init --load publish.el --eval "(setq debug-on-error t)" --funcall org-static-blog-publish
      [ $CI ] && blog-julia $CI
      cp -R static/ public/
    '';
  blog-serve = pkgs.writeShellScriptBin "blog-serve"
    ''
      ${pkgs.python3}/bin/python -m http.server --directory=public/ 8080
    ''; 
  blog-deploy = pkgs.writeShellScriptBin "blog-deploy"
    ''
      blog-build
      blog-compress
      [ $CI ] && blog-backup
      ${pkgs.rsync}/bin/rsync -avz --delete -e "${pkgs.openssh}/bin/ssh -F /dev/null -o 'StrictHostKeyChecking no' -i /tmp/deploy_rsa" public/ andrea@ccr.ydns.eu:~/www/ 
    '';  
  blog-backup = pkgs.writeShellScriptBin "blog-backup"
    ''
      filename="blog-backup.tar.gz"
      tar -czvf $filename public/
      mv $filename public/
    '';  
  blog-compress = pkgs.writeShellScriptBin "blog-compress"
    ''
      ${customPython}/bin/python compressor.py public/
    '';  
  blog-julia = pkgs.writeShellScriptBin "blog-julia"
    ''
      ${customPython}/bin/python julia.py $1
    '';
in
stdenv.mkDerivation rec {
  name = "blog";
  buildInputs = [
    blog-build
    blog-serve
    blog-deploy
    blog-backup
    blog-compress
    blog-julia
  ];
}

