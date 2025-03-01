#if package name contain - like git-delta just write it gitdelta but in the installation time write as it is git-delta
#

# set variable_name@package_and_depenencies@package_dir
set aria2 "c-ares,libxml2,aria2"@aria2
set apksinger apksigner@apksinger
set bat bat@a_semi_dependent
set ccrypt ccrypt@a_semi_dependent
set cmake "libxml2,binutils,ndk-sysroot,libffi,libllvm,lld,clang,libarchive,jsoncpp,rhash,cmake"@cmake
set curlie curlie@a_semi_dependent
set cronie cronie@a_semi_dependent
set dnsutils "openssl,dnsutils"@a_semi_dependent
set duf duf@a_semi_dependent
set dua dua@a_semi_dependent
set emacs "gnutls,libxml2,emacs"@emacs
set exa "libgit2,exa"@eza
set eza "libgit2,eza"@eza
set fastfetch "vulkan-loader-generic,vulkan-loader,fastfetch"@fastfetch
set fd fd@a_semi_dependent
set fish "libc++,ncurses,libandroid-support,ncurses-utils,man,m4,flex,bc,pcre2,libandroid-spawn,fish"@fish
set ffmpeg "littlecms,dbus,game-music-emu,libass,libudfread,libbluray,libmp3lame,libopencore-amr,libogg,libflac,libopus,libvorbis,libsndfile,libltdl,libsoxr,libwebrtc-audio-processing,speexdsp,pulseaudio,mpg123,libopenmpt,libsrt,libssh,libtheora,libv4l,libvo-amrwbenc,libvpx,libvidstab,libx264,libzimg,ocl-icd,svt-av1,xvidcore,ffmpeg"@ffmpeg
set fzf "tmux,fzf"@fzf
set gh gh@a_semi_dependent
set git git@git
set gitdelta "git-delta"@a_semi_dependent
set golang "golang"@golang
set gopls "gopls"@golang
set gnupg "pinentry,libsqlite,libnpth,libksba,libgnutls,gnupg"@gnupg
set httrack "httrack-data,httrack"@httrack
set hugo hugo@hugo
set hyperfine hyperfine@hyperfine
set imagemagick "brotli,fftw,fontconfig,freetype,fribidi,gdk-pixbuf,giflib,glib,harfbuzz,imagemagick,imath,libandroid-posix-semaphore,libandroid-shmem,libaom,libcairo,libdav1d,libde265,libffi,libgraphite,libheif,libjpeg-turbo,libjxl,liblzo,libpixman,libpng,librav1e,librsvg,libtiff,libwebp,libx11,libx265,libxau,libxcb,libxdmcp,libxext,libxft,libxml2,libxrender,littlecms,openexr,openjpeg,pango,ttf-dejavu,liblzma"@imagemagick
set java "brotli,ca-certificates-java,libpng,freetype,ttf-dejavu,fontconfig,giflib,libandroid-shmem,libice,libjpeg-turbo,libuuid,libsm,libxau,libxdmcp,libxcb,libx11,libxext,libxi,libxrender,libxrandr,libxt,libxtst,openjdk-17,openjdk-17-x"@java
set jq "oniguruma,jq"@jq
set libqrencode "libpng,libqrencode"@libqrencode
set libnotify "gdk-pixbuf,glib,libffi,libjpeg-turbo,libnotify,libtiff,libnotify"@libnotify
set libs ",libxml2,glib,libandroid-posix-semaphore,libandroid-support,libdav1d,libaom,libde265,libffi,libheif,libgnutls,libjpeg-turbo,liblzma,libpng,libnpth,libtiff,librav1e,libwebp,libx265,c-ares,libsqlite,libuuid,libgit2,libllvm,llvm,brotli,freetype,ttf-dejavu,fontconfig,giflib,libandroid-shmem,libice,libuuid,libsm,libxau,libxdmcp,libxcb,libx11,libxext,libxi,libxrender,libxrandr,libxt,libxtst,libllvm,libcompiler-rt,libcrypt,lld,libiconv,"@libs
set lua "liblua54,lua54"@lua
set lualanguageserver lua-language-server@coding
set make make@make
set nginx nginx@a_semi_dependent
set neovim "libmsgpack,libiconv,liblua51,libluajit,libuv,luv,libandroid-support,libvterm,libunibilium,libtermkey,lua51-lpeg,libtreesitter,tree-sitter,tree-sitter-c,ree-sitter-lua,tree-sitter-markdown,tree-sitter-lua,tree-sitter-query,tree-sitter-vimdoc,tree-sitter-vim,tree-sitter-parsers,neovim"@neovim
set newsboat "json-c,stfl,libsqlite,newsboat"@newsboat
set nodejs "libicu,c-ares,nodejs"@nodejs
set openssh "libdb,libresolv-wrapper,krb5,ldns,libedit,termux-auth,openssh-sftp-server,openssl-1.1,openssh"@openssh
# set openssl openssl@openssl
set openssltool openssl-tool@openssl-tool
set osspuuid ossp-uuid@ossp-uuid
set pandoc pandoc@a_semi_dependent
set pass pass@a_semi_dependent
set p7zip p7zip@a_semi_dependent
set pkgUpdate "ed,liblzma,xz-utils,zlib,zstd,libbz2,bzip2,libgmp,coreutils,libmd,diffutils,gzip,less,libandroid-glob,tar,dpkg,findutils,libgpg-error,libassuan,libgcrypt,libnpth,gpgv,grep,ca-certificates,openssl,libnghttp3,libcurl,curl,libnghttp2,libssh2,resolv-conf,libexpat,libevent,libunbound,unbound,libnettle,libunistring,libidn2,libgnutls,liblz4,sed,termux-am-socket,dash,libmpfr,readline,gawk,pcre2,procps,psmisc,termux-am,termux-exec,libsmartcols,libcap-ng,dialog,util-linux,termux-tools,termux-keyring,termux-licenses,xxhash,apt,bash,libcrypt,bash-completion,busybox,pcre,command-not-found,debianutils,dos2unix,inetutils2,libtirpc,lsof,nano,unzip,libtirpc,inetutils,unzip,libexpat,net-tools"@pkgUpdate
set progress "libandroid-wordexp,progress"@progress
set pv pv@progress
#require clang
set python "zlib,openssl,libcrypt,libandroid-support,ncurses,readline,gdbm,libandroid-posix-semaphore,ncurses-ui-libs,liblzma,libsqlite,libbz2,libffi,libexpat,ndk-sysroot,libxml2,libllvm,llvm,libcompiler-rt,clang,python,pkg-config,python-ensurepip-wheels,python-pip"@python
set ripgrep "pcre2,ripgrep"@ripgrep
set rsync "openssl-tool,libpopt,rsync"@rsync
# set rust "openssl,zlib,libc++,libllvm,lld,clang,rust-std-aarch64-linux-android,rust"@rust
set rust "rust-std-aarch64-linux-android,rust"@rust

# if you want to install it use app rust-analyzer dont ommit the dash
set rustanalyzer "rust-src,rust-analyzer"@rust-analyzer
set shfmt shfmt@coding
set sift sift@a_semi_dependent
set starship starship@starship
set strace "argp,libelf,libdw,strace"@strace
set stylua stylua@coding
set subversion "libuuid,apr,apr-util,libsqlite,serf,utf8proc,subversion"@subversion
set tealdeer tealdeer@tealdeer
set termuxapi termux-api@termux-api
set tree tree@tree
set uimagemagick "brotli fftw fontconfig freetype fribidi gdk-pixbuf giflib glib harfbuzz imagemagick imath libandroid-posix-semaphore libandroid-shmem libaom libcairo libdav1d libde265 libffi libgraphite libheif libjpeg-turbo libjxl liblzo libpixman libpng librav1e librsvg libtiff libwebp libx11 libx265 libxau libxcb libxdmcp libxext libxft libxrender littlecms openexr openjpeg pango ttf-dejavu"
set unrar unrar@a_semi_dependent
set w3m "libgc,w3m"@w3m
set wget "libuuid,wget"@wget
set wget "gpgme,wget2"@wget
set which which@a_semi_dependent
set xmlstarlet "libxml2,libxslt,xmlstarlet"@xmlstarlet
set zip "libandroid-support,zip"@zip
set zoxide zoxide@a_semi_dependent
set zsh zsh@a_semi_dependent
set markAsDepIgnoreList ",python,openssl-tool,jq,rust,gnupg,apt,curl,zip,unzip,glib,nodejs,git,gzip,zstd,openssl,"
# externals binaries written just for completion
# set hurl
# set httpie
# set omf 
# set apkeditor  
