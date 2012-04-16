# input plugin to read ogg files with lamip
#
# media-plugins/lamip-ogg

DESCRIPTION="Allow lamip to read ogg/vorbis files"
HOMEPAGE="http://fondriest.frederic.free.fr/realisations/lamip/"
SRC_URI="http://fondriest.frederic.free.fr/realisations/lamip/files/src/lamip-inputOGG_20040823.tar.bz2"

S="${WORKDIR}/inputogg"
LICENCE="GPL-2"
SLOT="0"
KEYWORDS="x86"
RESTRICT="nomirror"
DEPEND="
media-libs/libvorbis
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
