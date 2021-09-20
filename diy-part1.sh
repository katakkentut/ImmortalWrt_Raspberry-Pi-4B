#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.2/g' package/base-files/files/bin/config_generate

# Rename hostname to OpenWrt
sed -i 's/ImmortalWrt/OpenWrt/g' package/base-files/files/bin/config_generate

# enable wifi
sed -i 's/VHT80/VHT20/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# Add Firmware release link
sed -i "s#ImmortalWrt Core</a>#ImmortalWrt Core</a> / <a href="https://github.com/lxl6125/ImmortalWrt_Raspberry-Pi-4B/releases" target="_blank">Firmware release</a>#g" package/emortal/autocore/files/arm/index.htm

# Add build date to index page
sed -i '/exit 0/d' package/emortal/default-settings/files/zzz-default-settings
cat >> package/emortal/default-settings/files/zzz-default-settings << "EOF"
export orig_revision="$(cat "/etc/openwrt_release" | grep DISTRIB_REVISION | awk -F "'" '{print $2}')"
sed -i "s/${orig_revision}/build_date/" /etc/openwrt_release

exit 0
EOF
sed -i "s/build_date/($(date +"%Y-%m-%d"))/" package/emortal/default-settings/files/zzz-default-settings

# Use kernel version 5.10
sed -i "s/5.4/5.10/g" target/linux/bcm27xx/Makefile

