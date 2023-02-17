#!/bin/bash

# 设置为schedutil调度(根据内核修改版本)
sed -i '/CONFIG_CPU_FREQ_GOV_ONDEMAND=y/a\CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y' target/linux/ipq807x/config-5.10
sed -i 's/# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set/CONFIG_CPU_FREQ_GOV_POWERSAVE=y/g' target/linux/ipq807x/config-5.10
sed -i 's/# CONFIG_CPU_FREQ_STAT is not set/CONFIG_CPU_FREQ_STAT=y/g' target/linux/ipq807x/config-5.10

cp -f ../patch/mac80211.sh package/kernel/mac80211/files/lib/wifi
cp -f ../patch/boos-ath.mk package/kernel/mac80211
svn co https://github.com/coolsnowwolf/lede/trunk/package/qca/nss/qca-nss-ecm-64 package/qca/nss/qca-nss-ecm-64
svn co https://github.com/coolsnowwolf/lede/trunk/package/qca/nss/qca-nss-drv-64 package/qca/nss/qca-nss-drv-64
svn co https://github.com/coolsnowwolf/lede/trunk/package/qca/nss/qca-nss-clients-64 package/qca/nss/qca-nss-clients-64
cp -f ../patch/boos-ecm64-Makefile package/qca/nss/qca-nss-ecm-64/Makefile
sed -i s/10.10.10.1/192.168.1.1/g package/base-files/files/bin/config_generate

#rm -rf package/qca/nss/qca-nss-clients
#rm -rf package/qca/nss/qca-nss-ecm
#rm -rf package/qca/nss/qca-nss-drv

#sed -i s#Boos4721/packages.git#coolsnowwolf/packages.git#g feeds.conf.default
#sed -i s#github.com/Boos4721/packages.git#git.openwrt.org/feed/packages.git#g feeds.conf.default

#svn co https://github.com/Boos4721/openwrt/trunk/package package/boos-packages