# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PV="${PV/_/-}"
DESCRIPTION="libfprint"
HOMEPAGE="http://www.reactivated.net/fprint/wiki/Libfprint"
SRC_URI="mirror://sourceforge/fprint/${PN}-${MY_PV}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/libusb
	media-gfx/imagemagick"
S="${WORKDIR}/${PN}-${MY_PV}"

src_compile() {
		cd ${S}
		econf || die "configure failed"
	    emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
