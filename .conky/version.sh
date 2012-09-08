DISTRIB_INFO=$(cat /proc/version)

case "$DISTRIB_INFO" in
  *Debian*) echo "Debian";;
  *Ubuntu*) echo "Ubuntu";;
  *) echo "Generic Linux"
esac
