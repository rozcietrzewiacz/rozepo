# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="pam_fprint"
HOMEPAGE="http://www.reactivated.net/fprint/wiki/Pam_fprint"
SRC_URI="mirror://sourceforge/fprint/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="media-libs/libfprint
	sys-libs/pam"

src_install() {
	emake DESTDIR="${D}" install
}

pkg_postinst() {
	elog "You will need to update your system-auth pam module."
	elog "Please add \"auth sufficient pam_fprint.so\" to the"
	elog "second line of /etc/pam.d/system-auth."
}
