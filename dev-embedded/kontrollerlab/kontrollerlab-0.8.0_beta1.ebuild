# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit qt3 eutils

DESCRIPTION="The KontrollerLab is a tool which can be used for developing
microcontroller software."
HOMEPAGE="http://www.cadmaniac.org/projectMain.php?projectName=kontrollerlab"
SRC_URI="mirror://sourceforge/${PN}/${PN}-0.8.0-beta1.tar.bz2"
LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="kde"
DEPEND="kde? ( || ( kde-base/konqueror:3.5 kde-base/kdebase:3.5 ) )"
RDEPEND="${DEPEND}"
S="${WORKDIR}/kontrollerlab-0.8.0-beta1"

src_compile() {
	myconf="--prefix=`kde-config --prefix`
		     --without-arts"
	econf $myconf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
