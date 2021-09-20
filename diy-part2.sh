#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# TTYD automatic login
#sed -i 's#/bin/login#/usr/libexec/login.sh#g' feeds/packages/utils/ttyd/files/ttyd.config

# Replace qBittorrent-Enhanced-Edition
rm -rf feeds/packages/net/qBittorrent-Enhanced-Edition/patches
cp -f $GITHUB_WORKSPACE/qBittorrent-Enhanced-Edition feeds/packages/net/qBittorrent-Enhanced-Edition/Makefile

# Replace luci-app-openclash
rm -rf feeds/luci/applications/luci-app-openclash
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash feeds/luci/applications/luci-app-openclash
$GITHUB_WORKSPACE/preset-clash-core.sh armv8

# Replace luci-app-dockerman
rm -rf feeds/luci/applications/luci-app-dockerman
svn co https://github.com/lxl6125/luci-app-dockerman/trunk/applications/luci-app-dockerman feeds/luci/applications/luci-app-dockerman
sed -i '127,131s/#//' feeds/packages/utils/dockerd/Makefile

# Replace luci-app-unblockneteasemusic
rm -rf feeds/luci/applications/luci-app-unblockneteasemusic
git clone --depth=1 https://github.com/immortalwrt/luci-app-unblockneteasemusic.git feeds/luci/applications/luci-app-unblockneteasemusic

