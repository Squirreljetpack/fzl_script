case $1 in
test)
  FZL_INSTALL_DIR=$PWD/src $(realpath ./fzl) m._select.wg
  ;;
*) ;;
esac
