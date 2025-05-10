case $1 in
test)
  FZL_INSTALL_DIR=$PWD/src $(realpath ./fzl) main._select.wg
  ;;
*) ;;
esac
