# the default control plugin for lamip
#
# media-plugins/lamip-gtk2.ebuild

DESCRIPTION="Control lamip with this GUI based on gtk+2.x"
HOMEPAGE="http://fondriest.frederic.free.fr/realisations/lamip/"
SRC_URI="http://fondriest.frederic.free.fr/realisations/lamip/files/src/lamip-controlDEFAULT_20040823.tar.bz2"

RESTRICT="nomirror"
S="${WORKDIR}/controldefault"
LICENCE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="media-sound/lamip
	>=x11-libs/gtk+-2.0*"

src_compile() {

 WANT_AUTOCONF_2_5=1 WANT_AUTOMAKE=1.7 autoreconf -vifs
 econf ${myconf} || die
 emake || die "Compilation failed"
}

src_install() {
 make DESTDIR=${D} libdir=/usr/lib/lamip install || die "install failed"
# einstall install || die "Install failed"
}
