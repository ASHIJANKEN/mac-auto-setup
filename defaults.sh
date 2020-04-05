#!/bin/bash
cat << EOS

 AkkeyLab

 The elapsed time does not matter.
 Because speed is important.

EOS

#
# defaults
#
echo " ---------- defaults ---------"
# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -boolean true

# Disable shadow on taking screenshots
$ defaults write com.apple.screencapture disable-shadow -boolean true

# Show all extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# 検索時にデフォルトでカレントディレクトリを検索
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# USBやネットワークストレージに.DS_Storeファイルを作成しない
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# ステータスバーを非表示
$ defaults write com.apple.finder ShowStatusBar -bool false

# パスバーを非表示
$ defaults write com.apple.finder ShowPathbar -bool false

# スクロールバーの表示:マウスまたはトラックパッドに基づいて自動的に表示
defaults write -g AppleShowScrollBars -string "Automatic"

# Dockを自動的に表示/非表示
defaults write com.apple.dock autohide -bool true

# 右下で ディスプレイをスリープ
defaults write com.apple.dock wvous-br-corner -int 10
defaults write com.apple.dock wvous-br-modifier -int 0

# スリープとスクリーンセーバの解除にパスワードを要求
defaults write com.apple.screensaver askForPassword -bool true
# パスワードを要求するまでの秒数(60秒)
defaults write com.apple.screensaver askForPasswordDelay -int 60


# --------------------
# キーボード
# --------------------

# -- キーボード --

# F1、F2 などのすべてのキーを標準のファンクションキーとして使用 (オン)
defaults write com.apple.keyboard.fnState -boolean true

# -- 入力ソース --

# Windows 風のキー操作 (オン)
defaults write com.apple.inputmethod.Kotoeri JIMPrefShiftKeyActionKey -boolean true

# 推測表示 (オン)
defaults write com.apple.inputmethod.Kotoeri JIMPrefPredictiveCandidateKey -boolean true

# 句読点で変換 (オン)
defaults write com.apple.inputmethod.Kotoeri JIMPrefConvertWithPunctuationKey -boolean true

# "/"キーで入力する文字 (・(中黒))
defaults write com.apple.inputmethod.Kotoeri.plist JIMPrefCharacterForSlashKey -int 1

# "¥"キーで入力する文字 ("\" (バックスラッシュ))
defauls write com.apple.inputmethod.Kotoeri JIMPrefFullWidthNumeralCharactersKey -boolean true


# --------------------
# マウス
# --------------------

# スクロールの方向: ナチュラル
defaults write -g com.apple.swipescrolldirection -boolean true



# --------------------
# トラックパッド
# (http://baqamore.hatenablog.com/entry/2015/02/09/221934 参照)
# --------------------

# -- ポイントとクリック --

# 調べる & データ抽出 (オフ)
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerTapGesture -int 0

# 副ボタンのクリック (2本指でクリック)
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 0
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -boolean true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -boolean ture

# タップでクリック (オフ)
defaults write com.apple.AppleMultitouchTrackpad Clicking -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 0

# -- スクロールとズーム --

# スクロールの方向 (ナチュラル)

# 拡大／縮小 (2本指でピンチ)
defaults write com.apple.AppleMultitouchTrackpad TrackpadPinch -boolean true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadPinch -boolean true

# スマートズーム (2本指でダブルタップ)
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerDoubleTapGesture -boolean true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerDoubleTapGesture -boolean true

# 回転 (2本指で回転)
defaults write com.apple.AppleMultitouchTrackpad TrackpadRotate -boolean true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRotate -boolean true

# -- その他のジェスチャ --

# ページ間をスワイプ (オフ)
defaults write -g AppleEnableSwipeNavigateWithScrolls -boolean false

# フルスクリーンアプリケーション間をスワイプ (4本指で左右にスワイプ)
defaults write "com.apple.AppleMultitouchTrackpad" TrackpadFourFingerHorizSwipeGesture -int 2
defaults write "com.apple.driver.AppleBluetoothMultitouch.trackpad" TrackpadFourFingerHorizSwipeGesture -int 2

# 通知センター (2本指で右端から左にスワイプ)
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3

# Mission Control (4本指で上にスワイプ)
defaults write com.apple.AppleMultitouchTrackpad  TrackpadFourFingerVertSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad  TrackpadThreeFingerVertSwipeGesture -int 0
defaults write com.apple.dock  showMissionControlGestureEnabled -boolean true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad  TrackpadFourFingerVertSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad  TrackpadThreeFingerVertSwipeGesture -int 0

# アプリケーション Expose (4本指で下にスワイプ)
defaults write com.apple.AppleMultitouchTrackpad  TrackpadFourFingerVertSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad  TrackpadThreeFingerVertSwipeGesture -int 0
defaults write com.apple.dock  showAppExposeGestureEnabled -boolean true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerVertSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 0

# Launchpad (親指と3本指でピンチ)
defaults write com.apple.dock showLaunchpadGestureEnabled -boolean true

# デスクトップを表示 (親指と3本指で広げる)
defaults write com.apple.AppleMultitouchTrackpad TrackpadFiveFingerPinchGesture = 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerPinchGesture = 2
defaults write com.apple.dock showDesktopGestureEnabled = 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFiveFingerPinchGesture = 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerPinchGesture = 2


killall Finder
echo " ------------ END ------------"