#!/bin/bash

sudo apt update p7zip

# 修复Package/Makefile编译错误
sed -i s#system/opkg#opkg#g package/Makefile
# 本机预设
#svn co https://github.com/WLWolf5/wrtcompiler/trunk/config files
# 个人Patch
#svn co https://github.com/WLWolf5/wrtcompiler/trunk/patch
cp -f patch/104-RFC-ath11k-fix-peer-addition-deletion-error-on-sta-band-migration.patch package/kernel/mac80211/patches/ath11k
# 设置为schedutil调度(根据内核修改版本)
sed -i '/CONFIG_CPU_FREQ_GOV_ONDEMAND=y/a\CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y' target/linux/ipq807x/config-5.15
sed -i 's/# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set/CONFIG_CPU_FREQ_GOV_POWERSAVE=y/g' target/linux/ipq807x/config-5.15
sed -i 's/# CONFIG_CPU_FREQ_STAT is not set/CONFIG_CPU_FREQ_STAT=y/g' target/linux/ipq807x/config-5.15
# 修改连接数上限
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=65535' package/base-files/files/etc/sysctl.conf
# 设置默认NTP服务器
sed -i "s/0.openwrt.pool.ntp.org/ntp.aliyun.com/g" package/base-files/files/bin/config_generate
sed -i "s/1.openwrt.pool.ntp.org/cn.ntp.org.cn/g" package/base-files/files/bin/config_generate
sed -i "s/2.openwrt.pool.ntp.org/cn.pool.ntp.org/g" package/base-files/files/bin/config_generate

# 修改默认主机名
#sed -i 's/OpenWrt/Redmi-AX6/g' package/base-files/files/bin/config_generate
# 设置默认ip
#sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

#补充驱动
#svn co https://github.com/Boos4721/openwrt/trunk/package/firmware/ath11k-board package/openwrt-packages/ath11k-board

# Openwrt扩展软件包
#git clone https://github.com/kiddin9/openwrt-packages.git package/openwrt-packages

# 扩展软件包冲突处理
#rm -rf package/openwrt-packages/miniupnpd
#rm -rf package/openwrt-packages/miniupnpd-nft
#rm -rf package/openwrt-packages/miniupnpd-iptables
#rm -rf package/openwrt-packages/.github/diy/packages/miniupnpd-iptables
#rm -rf package/openwrt-packages/firewall
#rm -rf package/openwrt-packages/shortcut-fe
#rm -rf package/packages/net/miniupnpd
#svn co https://github.com/x-wrt/packages/trunk/net/miniupnpd package/openwrt-packages/miniupnpd

#Custom Theme
#svn co https://github.com/harry3633/openwrt-package/trunk/lienol/luci-theme-bootstrap-mod package/openwrt-packages/luci-theme-bootstrap-mod
#svn co https://github.com/harry3633/openwrt-package/trunk/lienol/luci-theme-argon-light-mod package/openwrt-packages/luci-theme-argon-light-mod
#svn co https://github.com/harry3633/openwrt-package/trunk/lienol/luci-theme-argon-dark-mod package/openwrt-packages/luci-theme-argon-dark-mod
#svn co https://github.com/a520ass/openwrt-third-packages/trunk/luci-theme-netgear package/openwrt-packages/luci-theme-netgear
#svn co https://github.com/kenzok8/small-package/trunk/luci-theme-argonne package/openwrt-packages/luci-theme-argonne
#svn co https://github.com/kenzok8/small-package/trunk/luci-theme-atmaterial_new package/openwrt-packages/luci-theme-atmaterial_new
#svn co https://github.com/kenzok8/small-package/trunk/luci-theme-neobird package/openwrt-packages/luci-theme-neobird
#svn co https://github.com/kenzok8/small-package/trunk/luci-theme-mcat package/openwrt-packages/luci-theme-mcat
#svn co https://github.com/kenzok8/small-package/trunk/luci-theme-dog package/openwrt-packages/luci-theme-dog
#svn co https://github.com/kenzok8/small-package/trunk/luci-app-argon-config package/openwrt-packages/luci-app-argon-config
#svn co https://github.com/kenzok8/small-package/trunk/luci-app-argonne-config package/openwrt-packages/luci-app-argonne-config