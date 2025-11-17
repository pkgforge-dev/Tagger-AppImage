#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q tagger | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/org.nickvision.tagger.svg
export DESKTOP=/usr/share/applications/org.nickvision.tagger.desktop
export DEPLOY_OPENGL=1
export DEPLOY_DOTNET=1
export STARTUPWMCLASS=tagger  # For Wayland, this is 'org.nickvision.tagger', so this needs to be changed in desktop file manually by the user in that case until some potential automatic fix exists for this

# Deploy dependencies
quick-sharun /usr/bin/tagger

# Turn AppDir into AppImage
quick-sharun --make-appimage
