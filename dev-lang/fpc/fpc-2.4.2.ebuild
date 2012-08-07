# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

RESTRICT="strip" #269221

#S="${WORKDIR}/usr/share/fpcsrc"

MY_PN="freepascal"
HOMEPAGE="http://www.freepascal.org/"
DESCRIPTION="Free Pascal Compiler"
SRC_URI="
	amd64? ( mirror://sourceforge/${MY_PN}/Linux/${PV}/${P}.x86_64-linux.tar )
	x86? ( mirror://sourceforge/${MY_PN}/Linux/${PV}/${P}.i386-linux.tar )
	source? ( mirror://sourceforge/${MY_PN}/Source/${PV}/${P}.source.tar.gz )"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1 LGPL-2.1-FPC"
KEYWORDS="~amd64 ~x86"
IUSE="doc source"

DEPEND="!dev-lang/fpc-bin
	!dev-lang/fpc-source"
RDEPEND="${DEPEND}"
#DEPEND="${DEPEND}
#	>=sys-devel/binutils-2.19.1-r1"

src_unpack() {
	case ${ARCH} in
		x86)	FPC_ARCH="i386" ;;
		ppc)	FPC_ARCH="ppc" ;;
		amd64)	FPC_ARCH="x86_64" ;;
		sparc)	FPC_ARCH="sparc" ;;
		*)	die "This ebuild doesn't support ${ARCH}." ;;
	esac
	PV_BIN=${PV}

	unpack ${A} || die "Unpacking ${A} failed!"

	#cd "${WORKDIR}"
	#for comp in *.deb; do
	#	ebegin "  Unpacking $comp"
	#	ar x "$comp"
	#	tar jxf data.tar.bz2
	#	eend $?
	#done

	#tar -xf binary.${FPC_ARCH}-linux.tar || die "Unpacking binary.${FPC_ARCH}-linux.tar failed!"
	unpack ./binary.${FPC_ARCH}-linux.tar || die "Unpacking binary.${FPC_ARCH}-linux.tar failed!"
	unpack ./base.${FPC_ARCH}-linux.tar.gz || die "Unpacking base.${FPC_ARCH}-linux.tar.gz failed!"
	#tar -xzf base.${FPC_ARCH}-linux.tar.gz || die "Unpacking base.${FPC_ARCH}-linux.tar.gz failed!"

	cd "${S}"
	sed -i -e 's/ -Xs / /g' $(find . -name Makefile) || die "sed failed"
}

set_pp() {
	case ${1} in
	bootstrap)	pp="${WORKDIR}"/lib/fpc/${PV_BIN}/ppc${FPC_ARCH} ;;
	new) 	pp="${S}"/compiler/ppc${FPC_ARCH} ;;
	*)	die "set_pp: unknown argument: ${1}" ;;
	esac
}

src_compile() {
	case ${ARCH} in
		x86)	FPC_ARCH="386" ;;
		ppc)	FPC_ARCH="ppc" ;;
		amd64)	FPC_ARCH="x64" ;;
		sparc)	FPC_ARCH="sparc" ;;
		*)	die "This ebuild doesn't support ${ARCH}." ;;
	esac
	local pp

	# Using the bootstrap compiler.
	set_pp bootstrap

	emake -j1 PP="${pp}" compiler_cycle || die "make compiler_cycle failed!"

	# Save new compiler from cleaning...
	cp "${S}"/compiler/ppc${FPC_ARCH} "${S}"/ppc${FPC_ARCH}.new

	# ...rebuild with current version...
	emake -j1 PP="${S}"/ppc${FPC_ARCH}.new compiler_cycle || die "make compiler_cycle failed!"

	# ..and clean up afterwards
	rm "${S}"/ppc${FPC_ARCH}.new

	# Using the new compiler.
	set_pp new

	emake -j1 PP="${pp}" rtl_clean || die "make rtl_clean failed"

	emake -j1 PP="${pp}" rtl packages_all utils || die "make failed"
}

src_install() {
	local pp
	set_pp new

	set -- PP="${pp}" FPCMAKE="${S}/utils/fpcm/fpcmake" \
		INSTALL_PREFIX="${D}"usr \
		INSTALL_DOCDIR="${D}"usr/share/doc/${P} \
		INSTALL_MANDIR="${D}"usr/share/man \
		INSTALL_SOURCEDIR="${D}"usr/lib/fpc/${PV}/source

	emake -j1 "$@" compiler_install rtl_install packages_install \
		utils_install || die "make install failed!"

	dosym ../lib/fpc/${PV}/ppc${FPC_ARCH} /usr/bin/ppc${FPC_ARCH}

	#cd "${S}"/../install/doc
	#emake -j1 "$@" installdoc || die "make installdoc failed!"

	cd "${S}"/../man
	doman man1/*.1 man5/*.5
	#emake -j1 "$@" installman || die "make installman failed!"

	if use doc ; then
		cd "${S}"/../share/doc || die
		insinto /usr/share/doc/${P}
		doins -r * || die "doins fpdocs failed"
		newins "${WORKDIR}"/fpc-${PV}-fpctoc.htx fpctoc.htx || die "newins fpctoc.htx failed"
	fi

	if use source ; then
		cd "${S}"
		shift
		emake -j1 PP="${D}"usr/bin/ppc${FPC_ARCH} "$@" sourceinstall || die "make sourceinstall failed!"
		find "${D}"usr/lib/fpc/${PV}/source -name '*.o' -exec rm {} \;
	fi

	"${D}"usr/lib/fpc/${PV}/samplecfg "${D}"usr/lib/fpc/${PV} "${D}"etc || die "samplecfg failed"
	sed -i -e "s:${D}:/:g" "${D}"etc/fpc.cfg || die "sed fpc.cfg failed"

	rm -rf "${D}"usr/lib/fpc/lexyacc
}
