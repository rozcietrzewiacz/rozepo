# input plugin to read musepack mpc/mp+ files with lamip
#
# media-plugins/lamip-mpc.ebuild

DESCRIPTION="Allow lamip to read mpc/mp+ files"
HOMEPAGE="http://fondriest.frederic.free.fr/realisations/lamip/"
SRC_URI="http://fondriest.frederic.free.fr/realisations/lamip/files/src/lamip-inputMPC_20040823.tar.bz2"

S="${WORKDIR}/inputmpc"
LICENCE="GPL-2"
SLOT="0"
KEYWORDS="x86"
RESTRICT="nomirror"
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
