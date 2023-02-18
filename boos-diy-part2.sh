#!/bin/bash

# 设置为schedutil调度(根据内核修改版本)
sed -i '/CONFIG_CPU_FREQ_GOV_ONDEMAND=y/a\CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y' target/linux/ipq807x/config-5.10
sed -i 's/# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set/CONFIG_CPU_FREQ_GOV_POWERSAVE=y/g' target/linux/ipq807x/config-5.10
sed -i 's/# CONFIG_CPU_FREQ_STAT is not set/CONFIG_CPU_FREQ_STAT=y/g' target/linux/ipq807x/config-5.10

# 添加核心温度的显示
sed -i 's|pcdata(boardinfo.system or "?")|luci.sys.exec("uname -m") or "?"|g' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm
sed -i 's/or "1"%>/or "1"%> ( <%=luci.sys.exec("expr `cat \/sys\/class\/thermal\/thermal_zone0\/temp` \/ 1000") or "?"%> \&#8451; ) /g' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm

rm -rf package/feeds/packages/net/miniupnpd
curl -LO https://raw.githubusercontent.com/WLWolf5/wrtcompiler/master/patch/boos-ath.mk
curl -LO https://raw.githubusercontent.com/WLWolf5/wrtcompiler/master/patch/mac80211.sh
mv -f mac80211.sh package/kernel/mac80211/files/lib/wifi/mac80211.sh
mv -f boos-ath.mk package/kernel/mac80211/ath.mk
svn co https://github.com/coolsnowwolf/lede/trunk/package/qca/nss/qca-nss-ecm-64 package/qca/nss/qca-nss-ecm-64
svn co https://github.com/coolsnowwolf/lede/trunk/package/qca/nss/qca-nss-drv-64 package/qca/nss/qca-nss-drv-64
svn co https://github.com/coolsnowwolf/lede/trunk/package/qca/nss/qca-nss-clients-64 package/qca/nss/qca-nss-clients-64
cp -f ../patch/boos-ecm64-Makefile package/qca/nss/qca-nss-ecm-64/Makefile
sed -i s/10.10.10.1/192.168.1.1/g package/base-files/files/bin/config_generate

# Openwrt扩展软件包
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-vlmcsd package/openwrt-packages/luci-app-vlmcsd
svn co https://github.com/kiddin9/openwrt-packages/trunk/vlmcsd package/openwrt-packages/vlmcsd
svn co https://github.com/openwrt/luci/trunk/applications/luci-app-nlbwmon package/openwrt-packages/luci-app-nlbwmon
svn co https://github.com/coolsnowwolf/packages/trunk/net/nlbwmon package/openwrt-packages/nlbwmon
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-fileassistant package/openwrt-packages/luci-app-fileassistant
svn co https://github.com/immortalwrt/luci/trunk/applications/luci-app-zerotier package/openwrt-packages/luci-app-zerotier
svn co https://github.com/immortalwrt/packages/trunk/net/zerotier package/openwrt-packages/zerotier
svn co https://github.com/kiddin9/openwrt-packages/trunk/fullconenat-nft package/openwrt-packages/fullconenat-nft


#rm -rf package/qca/nss/qca-nss-clients
#rm -rf package/qca/nss/qca-nss-ecm
#rm -rf package/qca/nss/qca-nss-drv

#sed -i s#Boos4721/packages.git#coolsnowwolf/packages.git#g feeds.conf.default
#sed -i s#github.com/Boos4721/packages.git#git.openwrt.org/feed/packages.git#g feeds.conf.default

#svn co https://github.com/Boos4721/openwrt/trunk/package package/boos-packages