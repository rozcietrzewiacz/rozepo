# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-panel/xfce4-panel-4.6.1.ebuild,v 1.9 2009/06/30 19:16:36 klausman Exp $

EAPI=5

inherit xfconf
#xfce4_core xfce4

DESCRIPTION="Panel"
SLOT="0"
HOMEPAGE="http://www.xfce.org/projects/xfce4-panel/"
#SRC_URI="mirror://xfce/src/xfce/${PN}/4.6/${P}.tar.bz2"
KEYWORDS="alpha amd64 arm hppa ia64 ~ppc ppc64 sparc x86 ~x86-fbsd"
LICENSE="GPL-2 LGPL-2"
IUSE="debug doc startup-notification"

RDEPEND=">=dev-libs/glib-2.20:2
	x11-libs/cairo
	x11-libs/libX11
	x11-libs/libSM
	>=x11-libs/gtk+-2.12:2
	>=x11-libs/libwnck-2.12
	>=xfce-base/libxfce4util-4.6
	>=xfce-base/libxfcegui4-4.6
	>=xfce-base/exo-0.3.100
	startup-notification? ( x11-libs/startup-notification )"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/panel-properties.patch" || die "panel-properties failed"
}

pkg_setup() {
	XFCONF="--disable-dependency-tracking
		$(use_enable startup-notification)
		$(use_enable debug)"
}

DOCS="AUTHORS ChangeLog HACKING NEWS README"
