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
# Memorize user pass
#
echo "Your Password: "
read -s pass;

#
# Log in to AppStore, iCloud, and so on
#
echo " --- Log in with Apple ID ----"
echo " Please log in to AppStore, iCloud, and so on with your Apple ID."

while :
do
  echo -n "After logging in, please type 'go': "
  read GO_STR
    if [ "$GO_STR" = "go" ]; then
      break
    else
      echo "Invalid input."
  fi
done
echo " ------------ END ------------"

#
# Install dotfiles system
#
echo " ---------- dotfiles ---------"
git clone --recursive git@github.com:ASHIJANKEN/dotfiles.git "~/dotfiles"
~/dotfiles/mklink_osx.command
echo " ------------ END ------------"

#
# install brew packages (tap, brew, cask, mas)
#
echo " --- tap, brew, cask, mas ----"
echo $pass | sudo chown -R $(whoami) /usr/local
brew bundle --global
echo " ------------ END ------------"

#
# Install zsh
#
if ! command_exists zsh ; then
  echo " ------------ zsh ------------"
  brew install zsh zsh-autosuggestions zsh-completions zsh-syntax-highlighting colordiff peco
  which -a zsh
  echo $pass | sudo -S -- sh -c 'echo '/usr/local/bin/zsh' >> /etc/shells'
  chsh -s /usr/local/bin/zsh
  source ~/.zshrc
  echo " ------------ END ------------"
fi

# #
# # Install vim
# #
# if ! command_exists vim ; then
#   echo " ------------ Vim ------------"
#   brew install vim --with-override-system-vi
#   echo " ------------ END ------------"
# fi

# #
# # Powerline
# #
# echo " --------- Powerline ---------"
# # Font is 14pt Iconsolata for Powerline with Solarized Dark iterm2 colors.
# git clone https://github.com/bhilburn/powerlevel9k.git ~/powerlevel9k
# git clone https://github.com/powerline/fonts.git ~/fonts
# ~/fonts/install.sh
# echo " ------------ END ------------"

# #
# # Install ruby
# #
# if ! command_exists rbenv ; then
#   echo " ----------- Ruby ------------"
#   brew install rbenv
#   brew install ruby-build
#   rbenv --version
#   rbenv install -l
#   ruby_latest=$(rbenv install -l | grep -v '[a-z]' | tail -1 | sed 's/ //g')
#   rbenv install $ruby_latest
#   rbenv global $ruby_latest
#   rbenv rehash
#   ruby -v
#   echo " ------------ END ------------"
# fi

# #
# # Install Node.js env
# #
# if ! command_exists nodebrew ; then
#   echo " ---------- Node.js ----------"
#   curl -L git.io/nodebrew | perl - setup
#   nodebrew ls-remote
#   nodebrew install-binary latest
#   nodebrew ls
#   nodebrew use latest
#   node -v
#   npm -v
#   echo " ------------ END ------------"
# fi

# #
# # Install Yarn
# #
# if ! command_exists yarn ; then
#   echo " ----------- Yarn ------------"
#   brew install yarn
#   echo " ------------ END ------------"
# fi

#
# TeX settings
#
if ! command_exists tex ; then
  echo " ------------ TeX ------------"
  ORIGIN_PATH=`pwd`

  brew install imagemagick ghostscript
  brew cask install mactex

  # Tex Live Utility > preference > path -> /Library/TeX/texbin
  version=$(tex -version | grep -oE '2[0-9]{3}' | head -1)
  echo $pass | sudo -S /usr/local/texlive/$version/bin/x86_64-darwin/tlmgr path add
  echo $pass | sudo -S tlmgr update --self --all

  sudo mkdir -p /usr/local/texlive/texmf-local/fonts/opentype/screen/hiragino
  cd /usr/local/texlive/texmf-local/fonts/opentype/screen/hiragino
  sudo ln -s "/Library/Fonts/ヒラギノ明朝 Pro W3.otf" HiraMinPro-W3.otf
  sudo ln -s "/Library/Fonts/ヒラギノ明朝 Pro W6.otf" HiraMinPro-W6.otf
  sudo ln -s "/Library/Fonts/ヒラギノ丸ゴ Pro W4.otf" HiraMaruPro-W4.otf
  sudo ln -s "/Library/Fonts/ヒラギノ角ゴ Pro W3.otf" HiraKakuPro-W3.otf
  sudo ln -s "/Library/Fonts/ヒラギノ角ゴ Pro W6.otf" HiraKakuPro-W6.otf
  sudo ln -s "/Library/Fonts/ヒラギノ角ゴ Std W8.otf" HiraKakuStd-W8.otf
  sudo ln -s "/System/Library/Fonts/ヒラギノ明朝 ProN W3.otf" HiraMinProN-W3.otf
  sudo ln -s "/System/Library/Fonts/ヒラギノ明朝 ProN W6.otf" HiraMinProN-W6.otf
  sudo ln -s "/Library/Fonts/ヒラギノ丸ゴ ProN W4.otf" HiraMaruProN-W4.otf
  sudo ln -s "/System/Library/Fonts/ヒラギノ角ゴ ProN W3.otf" HiraKakuProN-W3.otf
  sudo ln -s "/System/Library/Fonts/ヒラギノ角ゴ ProN W6.otf" HiraKakuProN-W6.otf
  sudo ln -s "/Library/Fonts/ヒラギノ角ゴ StdN W8.otf" HiraKakuStdN-W8.otf

  sudo mkdir -p /usr/local/texlive/texmf-local/fonts/opentype/jiyukobo/yu
  cd /usr/local/texlive/texmf-local/fonts/opentype/jiyukobo/yu
  sudo ln -s "/Library/Fonts/Yu Mincho Medium.otf" YuMin-Medium.otf
  sudo ln -s "/Library/Fonts/Yu Mincho Demibold.otf" YuMin-Demibold.otf
  sudo ln -s "/Library/Fonts/Yu Gothic Medium.otf" YuGo-Medium.otf
  sudo ln -s "/Library/Fonts/Yu Gothic Bold.otf" YuGo-Bold.otf

  sudo mkdir -p /usr/local/texlive/texmf-local/fonts/truetype
  cd $(dirname $(gs --help | grep "Resource/Font" | awk '{print $1}'))
  sudo zsh -c "rm ./CIDFont/*(@) ./CIDFSubst/*(@)"
  cd /usr/local/texlive/$version/texmf-dist/scripts/cjk-gs-integrate
  sudo perl cjk-gs-integrate.pl --link-texmf

  sudo mktexlsr
  sudo kanji-config-updmap-sys hiragino-pron

  # # JPN Lang settings
  # cd /usr/local/texlive/$version/texmf-dist/scripts/cjk-gs-integrate
  # echo $pass | sudo -S perl cjk-gs-integrate.pl --link-texmf --force
  # echo $pass | sudo -S mktexlsr
  # echo $pass | sudo -S kanji-config-updmap-sys hiragino-elcapitan-pron
  # # Select ==> TeXShop > Preferences > Source > pTeX (ptex2pdf)

  cd $ORIGIN_PATH
  echo " ------------ END ------------"
fi

#
# ESP-IDF
#
echo " ---------- ESP-IDF ----------"

ORIGIN_PATH=`pwd`

sudo easy_install pip
pip install --user pyserial
brew install cmake ninja
cd ~/esp
git clone -b v4.0 --recursive https://github.com/espressif/esp-idf.git
cd ~/esp/esp-idf
./install.sh
. $HOME/esp/esp-idf/export.sh
cd ~/esp
cp -r $IDF_PATH/examples/get-started/hello_world .

cd $ORIGIN_PATH
echo " ------------ END ------------"

echo " ---------- defaults ---------"
# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -boolean true



killall Finder
echo " ------------ END ------------"

echo " ------ Install manually -----"
cat << EOS
 Install softwares listed below manually.

 - bluetoothファイル交換
 - FileZilla(マルウェアの懸念からcaskから削除)
 - Illustrator
 - Mplab
 - Vdmx5
 - karabiner-eventviewer(karabiner-elementsだけで事足りそうならいらない)
 - Finderpath
 - insomaniax(mojaveじゃ使えないという噂)
 - Gravitdesigner
 - Easyontheeyes
 - Microsoft onenote(まぁいらない)
 - Microsoft Remote Desktop
 - カスペルスキー

EOS
echo " ------------ END ------------"


# #
# # Install wget
# #
# if ! command_exists wget ; then
#   echo " ----------- wget ------------"
#   brew install wget
#   wget --version
#   echo " ------------ END ------------"
# fi

# #
# # CocoaPods
# #
# if ! command_exists pod ; then
#   echo " --------- CocoaPods ---------"
#   echo $pass | sudo -S gem install -n /usr/local/bin cocoapods --pre
#   pod setup
#   echo " ------------ END ------------"
# fi

# #
# # Carthage
# #
# if ! command_exists carthage ; then
#   echo " --------- Carthage ----------"
#   brew install carthage
#   echo " ------------ END ------------"
# fi

# #
# # swiftenv
# #
# if ! command_exists swiftenv ; then
#   echo " --------- swiftenv ----------"
#   brew install kylef/formulae/swiftenv
#   echo 'if which swiftenv > /dev/null; then eval "$(swiftenv init -)"; fi' >> ~/.yadr/zsh/private.zsh
#   swiftenv rehash
#   echo " ------------ END ------------"
# fi

# while true; do
#   read -p 'Now install web apps? [Y/n]' Answer
#   case $Answer in
#     '' | [Yy]* )
#       $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/app.sh
#       break;
#       ;;
#     [Nn]* )
#       echo "Skip install"
#       break;
#       ;;
#     * )
#       echo Please answer YES or NO.
#   esac
# done;

# while true; do
#   read -p 'Now install App Store apps? [Y/n]' Answer
#   case $Answer in
#     '' | [Yy]* )
#       $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/appstore.sh
#       break;
#       ;;
#     [Nn]* )
#       echo "Skip install"
#       break;
#       ;;
#     * )
#       echo Please answer YES or NO.
#   esac
# done;

# read -p 'Please enter your GitHub Access Token. You can skip by typing "N".' Answer
# case $Answer in
#   '' | [Nn]* )
#     echo "Skip"
#     ;;
#   * )
#     echo "export GITHUB_ACCESS_TOKEN=${Answer}" >> ~/.yadr/zsh/private.zsh
#     echo "export HOMEBREW_GITHUB_API_TOKEN=${Answer}" >> ~/.yadr/zsh/private.zsh
#     echo "Writing to ~/.yadr/zsh/private.zsh is complete."
#     echo " ------------ END ------------"
# esac
