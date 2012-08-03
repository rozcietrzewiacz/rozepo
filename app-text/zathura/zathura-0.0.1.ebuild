# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="zathura is a highly customizable pdf viewer based on the poppler
pdf rendering library"
HOMEPAGE="http://zathura.neldoreth.net"
SRC_URI="http://zathura.neldoreth.net/files/${P}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="virtual/poppler
		>=x11-libs/cairo-1.8.8
		>=x11-libs/gtk+-2.16"
DEPEND="${RDEPEND}"

#src_unpack() {
#	unpack ${A}
#	cd "${S}"
#	epatch "${FILESDIR}/fix-makefile.patch" || die "epatch failed"
#}

src_compile() {
	#econf || die
	emake || die
}

src_install() {
	#dodir /usr/bin
	#make install || die
	exeinto /usr/bin/
	doexe zathura
}

