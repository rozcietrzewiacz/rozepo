#
# ebuild for lamip-0.0.2 an audio player for linux
#
# Linux Audio Multiple Interface Player
#
# install in media-sound/lamip/lamip-0.0.2.ebuild
#

IUSE="curl"

DESCRIPTION="LAMIP is an audio player similar to xmms but with UI plugins"
HOMEPAGE="http://fondriest.frederic.free.fr/realisations/lamip/"
SRC_URI="http://fondriest.frederic.free.fr/realisations/lamip/files/src/lamip_20040823.tar.bz2"
S="${WORKDIR}/lamip"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="curl? ( >=net-ftp/curl-7.10* )
	sys-devel/automake
	sys-devel/autoconf
	sys-devel/libtool"

src_compile() {
 local myconf=""

 if [ `use curl` ]; then
	myconf="${myconf} --enable-network"
 fi

 WANT_AUTOCONF_2_5=1 WANT_AUTOMAKE=1.7 autoreconf -vifs
 econf ${myconf} || die
 emake || die "Compilation failed"
}

src_install() {
 einstall || die "Install failed"
}
