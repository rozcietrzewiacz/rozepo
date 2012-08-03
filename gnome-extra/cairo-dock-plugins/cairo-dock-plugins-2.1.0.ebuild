# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnome2

MY_PN="${PN/-plugins}"

DESCRIPTION="Official plugins for cairo-dock"
HOMEPAGE="http://www.cairo-dock.org"
SRC_URI="mirror://berlios/${MY_PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="alsa gnome xfce"

RDEPEND="~gnome-extra/cairo-dock-${PV}
	x11-libs/vte"

src_compile() {
	econf \
			$(use_enable gnome gnome-integration) \
			$(use_enable xfce xfce-integration) \
			$(use_enable alsa alsa-mixer) \
			--disable-old-gnome-integration \
			--enable-terminal || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake failed"
}
