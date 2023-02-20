#!/bin/bash

# 添加核心温度的显示
sed -i 's|pcdata(boardinfo.system or "?")|luci.sys.exec("uname -m") or "?"|g' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm
sed -i 's/or "1"%>/or "1"%> ( <%=luci.sys.exec("expr `cat \/sys\/class\/thermal\/thermal_zone0\/temp` \/ 1000") or "?"%> \&#8451; ) /g' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm

#TCP-BBRv2
cp -f tcp-bbr2/* target/linux/generic/hack-5.15

#TCP流量优化
#wget https://raw.githubusercontent.com/WLWolf5/wrtcompiler/master/patch/780-v5.17-tcp-defer-skb-freeing-after-socket-lock-is-released.patch -P target/linux/generic/backport-5.15
#rm -rf build_dir/target-aarch64_cortex-a53_musl/linux-ipq807x_generic/linux-5.15.92/net/ipv4/tcp.c
#wget https://raw.githubusercontent.com/WLWolf5/wrtcompiler/master/patch/tcp.c -P build_dir/target-aarch64_cortex-a53_musl/linux-ipq807x_generic/linux-5.15.92/net/ipv4

# Openwrt扩展软件包
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-vlmcsd package/openwrt-packages/luci-app-vlmcsd
svn co https://github.com/kiddin9/openwrt-packages/trunk/vlmcsd package/openwrt-packages/vlmcsd
svn co https://github.com/openwrt/luci/trunk/applications/luci-app-nlbwmon package/openwrt-packages/luci-app-nlbwmon
svn co https://github.com/coolsnowwolf/packages/trunk/net/nlbwmon package/openwrt-packages/nlbwmon
svn co https://github.com/kiddin9/openwrt-packages/trunk/luci-app-fileassistant package/openwrt-packages/luci-app-fileassistant
svn co https://github.com/immortalwrt/luci/trunk/applications/luci-app-zerotier package/openwrt-packages/luci-app-zerotier
svn co https://github.com/immortalwrt/packages/trunk/net/zerotier package/openwrt-packages/zerotier
svn co https://github.com/kiddin9/openwrt-packages/trunk/fullconenat-nft package/openwrt-packages/fullconenat-nft
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/ddns-scripts_aliyun package/openwrt-packages/ddns-scripts_aliyun
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/ddns-scripts_dnspod package/openwrt-packages/ddns-scripts_dnspod
git clone https://github.com/NagaseKouichi/luci-app-dnsproxy.git package/openwrt-packages/luci-app-dnsproxy
svn co https://github.com/kiddin9/openwrt-packages/trunk/udp2raw package/openwrt-packages/udp2raw
git clone https://github.com/0xACE8/luci-app-udp2raw.git package/openwrt-packages/luci-app-udp2raw

svn co https://github.com/WLWolf5/wrtcompiler/trunk/patch/nss/qca-nss-crypto package/openwrt-packages/qca-nss-crypto
svn co https://github.com/WLWolf5/wrtcompiler/trunk/patch/nss/qca-nss-cfi package/openwrt-packages/qca-nss-cfi
svn co https://github.com/WLWolf5/wrtcompiler/trunk/patch/nss/qca-nss-drv package/openwrt-packages/qca-nss-drv