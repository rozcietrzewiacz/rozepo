# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils gnome2

DESCRIPTION="Cairo-dock is a fast, responsive, Mac OS X-like dock."
HOMEPAGE="http://www.cairo-dock.org"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="glitz"
RESTRICT="mirror"

DEPEND="
	dev-libs/dbus-glib
	>=dev-libs/glib-2.0.0
	dev-libs/libxml2
	gnome-base/librsvg
	sys-apps/dbus
	x11-libs/cairo[svg]
	>=x11-libs/gtk+-2.0.0
	x11-libs/gtkglext
	glitz? (
		media-libs/glitz
		x11-libs/cairo[glitz]
	)
"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fixes the missing cairo-dock-callbacks.h include
	# It's fixed in trunk already
#	epatch "${FILESDIR}/${PN}-missing-header.patch"
	#
	# Contributed mod by Michal Janke
# Narazie BEZ:	epatch "${FILESDIR}/${PN}-hotkey-unhide.patch"
}

src_configure() {
	G2CONF="${G2CONF} $(use_enable glitz)"

	econf \
		--enable-xextend \
		$(use_enable glitz) || die "econf failed"
}
