# input plugin to read wav pcm 16bits files with lamip
#
# media-plugins/lamip-wav.ebuild

DESCRIPTION="Allow lamip to read wav pcm files"
HOMEPAGE="http://fondriest.frederic.free.fr/realisations/lamip/"
SRC_URI="http://fondriest.frederic.free.fr/realisations/lamip/files/src/lamip-inputWAV_20040823.tar.bz2"

RESTRICT="nomirror"
S="${WORKDIR}/inputwav"
LICENCE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="media-sound/lamip"

src_compile() {

 WANT_AUTOCONF_2_5=1 WANT_AUTOMAKE=1.7 autoreconf -vifs
 econf ${myconf} || die
 emake || die "Compilation failed"
}

src_install() {
 make DESTDIR=${D} libdir=/usr/lib/lamip install || die "install failed"
# einstall install || die "Install failed"
}
