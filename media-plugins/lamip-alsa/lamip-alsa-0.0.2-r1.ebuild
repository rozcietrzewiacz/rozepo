# output plugin to ALSA for lamip
#
# media-plugins/lamip-alsa.ebuild

DESCRIPTION="Allow lamip to output sound to alsa"
HOMEPAGE="http://fondriest.frederic.free.fr/realisations/lamip/"
SRC_URI="http://fondriest.frederic.free.fr/realisations/lamip/files/src/lamip-outputALSA_20040719.tar.bz2"

RESTRICT="nomirror"
S="${WORKDIR}/outputalsa"
LICENCE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="media-libs/alsa-lib
media-sound/lamip"
src_compile() {

 WANT_AUTOCONF_2_5=1 WANT_AUTOMAKE=1.7 autoreconf -vifs
 econf ${myconf} || die
 emake || die "Compilation failed"
}

src_install() {
 make DESTDIR=${D} libdir=/usr/lib/lamip install || die "install failed"
# einstall install || die "Install failed"
}
