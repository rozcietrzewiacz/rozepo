# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit linux-mod

DESCRIPTION="r8168 driver for Realtek 8111/8168 PCI-E NICs"
HOMEPAGE="http://www.realtek.com.tw"

# looks like realtek doesnt want automatic downloads
#  ftp://202.134.71.22/cn/nic/${P}.tar.bz2
#  ftp://218.210.127.133/cn/nic/${P}.tar.bz2
#  ftp://152.104.238.19/cn/nic/${P}.tar.bz2"

# http://www.ezlinuxadmin.com/2010/04/upgrading-a-realtech-lan-nic-driver/
SRC_URI="http://www.downloadspot.com/downloads/r8168-8.018.00.tar.bz2"

SLOT="0"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/linux-sources"
RDEPEND="${DEPEND}"

BUILD_PARAMS="KVER=${KV}"
BUILD_TARGETS="modules"

MODULE_NAMES="r8168(net:${S}:${S}/src)"

CONFIG_CHECK="!R8169"
ERROR_R8169="${P} requires Realtek 8169 PCI Gigabit Ethernet adapter
(CONFIG_R8169) to be DISABLED"

src_unpack() {
	unpack ${A}
	cd "${S}"
	if kernel_is -ge 2 6 35 ; then
		epatch "${FILESDIR}/${PN}-kernel2_6_35.patch"
	fi
}

src_install() {
	dodoc README
	linux-mod_src_install
}


