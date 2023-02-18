#!/bin/bash

# 添加核心温度的显示
sed -i 's|pcdata(boardinfo.system or "?")|luci.sys.exec("uname -m") or "?"|g' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm
sed -i 's/or "1"%>/or "1"%> ( <%=luci.sys.exec("expr `cat \/sys\/class\/thermal\/thermal_zone0\/temp` \/ 1000") or "?"%> \&#8451; ) /g' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm

rm -rf feeds/packages/net/miniupnpd

# Openwrt扩展软件包
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-vlmcsd package/openwrt-packages/luci-app-vlmcsd
svn co https://github.com/kiddin9/openwrt-packages/trunk/vlmcsd package/openwrt-packages/vlmcsd
svn co https://github.com/openwrt/luci/trunk/applications/luci-app-nlbwmon package/openwrt-packages/luci-app-nlbwmon
svn co https://github.com/coolsnowwolf/packages/trunk/net/nlbwmon package/openwrt-packages/nlbwmon
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-fileassistant package/openwrt-packages/luci-app-fileassistant
svn co https://github.com/immortalwrt/luci/trunk/applications/luci-app-zerotier package/openwrt-packages/luci-app-zerotier
svn co https://github.com/immortalwrt/packages/trunk/net/zerotier package/openwrt-packages/zerotier
svn co https://github.com/kiddin9/openwrt-packages/trunk/fullconenat-nft package/openwrt-packages/fullconenat-nft