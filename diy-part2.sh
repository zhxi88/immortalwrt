#!/bin/bash
set -e

# 修改默认IP为 192.168.1.6
sed -i 's/192.168.31.1/192.168.1.6/g' package/base-files/files/bin/config_generate

# 主机名、时区
sed -i 's/ImmortalWrt/AX6000-25.12/g' package/base-files/files/bin/config_generate
sed -i 's/Asia\/Shanghai/Asia\/Shanghai/g' package/base-files/files/bin/config_generate

# 拉取第三方插件
git clone https://github.com/xiaorouji/openwrt-passwall-packages.git package/passwall-packages
git clone https://github.com/xiaorouji/openwrt-passwall.git package/luci-app-passwall
git clone https://github.com/vernesong/OpenClash.git package/luci-app-openclash
git clone https://github.com/destan19/OpenAppFilter.git package/luci-app-oaf
git clone https://github.com/huazai008/luci-app-turboacc.git package/luci-app-turboacc

# 清理冲突
rm -rf feeds/luci/applications/luci-app-wol
rm -rf feeds/luci/applications/luci-app-ddns

# 更新安装 feeds
./scripts/feeds update -a
./scripts/feeds install -a

