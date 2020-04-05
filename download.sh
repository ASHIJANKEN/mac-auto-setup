#!/bin/bash
cat << EOS

 AkkeyLab

 The elapsed time does not matter.
 Because speed is important.

EOS

function command_exists {
  command -v "$1" > /dev/null;
}

#
# Install homebrew.
#
if ! command_exists brew ; then
  echo " --------- Homebrew ----------"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update
  brew upgrade --all --cleanup
  brew -v
  echo " ------------ END ------------"
fi

#
# Install git
#
if ! command_exists git ; then
  echo " ------------ Git ------------"
  brew install git
  git --version
  echo " ------------ END ------------"
fi

#
# support ssh connection with git
#
echo " ---- Git SSH connection -----"
cat << EOS
 Please make sure that this computer can connect to the GitHub with SSH.

 Enter the commands below.
 You have successfully connected with SSH if you get sentences like "Hi ASHIJANKEN! You've successfully authenticated."

 $ ssh -T git@github.com

EOS

while :
do
  echo -n "After checking, please type 'go': "
  read GO_STR
    if [ "$GO_STR" = "go" ]; then
      break
    else
      echo "Invalid input."
  fi
done
echo " ------------ END ------------"

#
# mac-auto-setup.git
#
echo " ---- mac-auto-setup.git -----"
git clone git@github.com:ASHIJANKEN/mac-auto-setup.git
echo " ------------ END ------------"

#
# Move on to installation step
#
while true; do
  echo -n "Move on to the installation step? [y/n]: "
  read NEXT
  case $NEXT in
    [Yy]*)
      ./mac-auto-setup/setup.sh
      break
      ;;
    [Nn]*)
      break
      ;;
    *)
      echo "Invalid input."
      ;;
  esac
done
