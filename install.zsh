#!/bin/zsh

INSTALL_DIR=/etc/fzl

check_fzs() {
  command -v "fzs" >/dev/null 2>&1 && return 0
  echo "Please first install fzs (git@github.com:Squirreljetpack/fzs.git)." >2
  exit 1
}
FZS_DATA_DIR=${FZS_DATA_DIR:-'~'/.local/share/fzs}

if [[ SYSTEM_INSTALL == true ]]; then
  # todo: figure out brew/aur
  INSTALL_ROOT=${INSTALL_ROOT:-""}
  INSTALL_DIR=$INSTALL_ROOT/$INSTALL_DIR
  [[ -e $INSTALL_DIR ]] && rm -rf $INSTALL_DIR
  cp -r src $INSTALL_DIR
  cat <<EOF >$INSTALL_DIR/start.zshrc
. $FZS_DATA_DIR/fzs_plugins.zsh
. $FZS_DATA_DIR/fzs_init.zsh
EOF
  cp fzl $INSTALL_ROOT/usr/bin/fzl
else
  check_fzs
  if ! [ -e "$INSTALL_DIR" ]; then
    mkdir -p "$INSTALL_DIR"
  fi
  if [ -w "$INSTALL_DIR" ] && [ -x "$INSTALL_DIR" ]; then
    [[ -e $INSTALL_DIR ]] && rm -rf $INSTALL_DIR
    cp -r src "$INSTALL_DIR"
    cat <<EOF >$INSTALL_DIR/start.zshrc
. $FZS_DATA_DIR/fzs_plugins.zsh
. $FZS_DATA_DIR/fzs_init.zsh
EOF
  else
    echo "Insufficient permission to modify $INSTALL_DIR." >&2
    exit 1
  fi

  cp fzl ${INSTALL_PATH:-/usr/local/bin/fzl}
fi
