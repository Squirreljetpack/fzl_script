#!/bin/zsh

INSTALL_DIR=/etc/fzl

if [[ SYSTEM_INSTALL == true ]]; then
  # todo: figure out brew/aur
  INSTALL_ROOT=${INSTALL_ROOT:-""}
  INSTALL_DIR=$INSTALL_ROOT/$INSTALL_DIR
  [[ -e $INSTALL_DIR ]] && rm -rf $INSTALL_DIR
  cp -r src $INSTALL_DIR
  cp fzl $INSTALL_ROOT/usr/bin/fzl
else
  if ! [ -e "$INSTALL_DIR" ]; then
    mkdir -p "$INSTALL_DIR"
  fi
  if [ -w "$INSTALL_DIR" ] && [ -x "$INSTALL_DIR" ]; then
    [[ -e $INSTALL_DIR ]] && rm -rf $INSTALL_DIR
    cp -r src "$INSTALL_DIR"
  else
    echo "Insufficient permission to modify $INSTALL_DIR." >&2
    exit 1
  fi

  cp fzl ${INSTALL_PATH:-/usr/local/bin/fzl}
fi
