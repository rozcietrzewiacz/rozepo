# Copyright 1999-2010 Tiziano Müller
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit versionator

DESCRIPTION="Event-based replacement for the /sbin/init daemon."
HOMEPAGE="http://upstart.ubuntu.com/"
SRC_URI="http://upstart.ubuntu.com/download/$(get_version_component_range 1-2)/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+threads vim-syntax"

RDEPEND=">=sys-libs/libnih-1.0.0
	>=sys-apps/dbus-1.2.16"
#	!sys-apps/sysvinit"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig"

src_configure() {
	econf \
		$(use_enable threads) \
		$(use_enable threads threading)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog HACKING NEWS README TODO

	if use vim-syntax ; then
		insinto /usr/share/vim/vimfiles/syntax
		doins contrib/vim/syntax/upstart.vim
		insinto /usr/share/vim/vimfiles/ftdetect
		doins contrib/vim/ftdetect/upstart.vim
	fi
}

