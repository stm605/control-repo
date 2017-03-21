class role::sapapp {

#  include hanapartition app servers don't need the disk config
  include hanaconfig
  include sapmount

}
