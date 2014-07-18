# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/plowshare/plowshare-20120609-r2.ebuild,v 1.1 2012/07/11 15:35:41 volkmar Exp $

### based on plowshare-20120609-r2.ebuild

EAPI="4"

inherit bash-completion-r1

MY_P="${PN}-snapshot-git${PV}.eaee2c3"

DESCRIPTION="Command-line downloader and uploader for file-sharing websites"
HOMEPAGE="http://code.google.com/p/plowshare/"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~x86"
IUSE="bash-completion +javascript +perl scripts view-captcha"

RDEPEND="
	!net-misc/plowshare
	javascript? ( dev-lang/spidermonkey )
	perl? ( dev-lang/perl
		media-gfx/imagemagick[perl] )
	view-captcha? ( || ( media-gfx/aview media-libs/libcaca ) )
	>=app-shells/bash-4.1
	|| ( app-text/recode ( dev-lang/perl dev-perl/HTML-Parser ) )
	app-text/tesseract[tiff]
	|| ( media-gfx/imagemagick[tiff] media-gfx/graphicsmagick[imagemagick,tiff] )
	>=net-misc/curl-7.24
	|| ( net-misc/curl[curl_ssl_openssl]
		net-misc/curl[curl_ssl_cyassl]
		net-misc/curl[curl_ssl_gnutls]
		net-misc/curl[curl_ssl_polarssl]
		net-misc/curl[curl_ssl_nss] )
	sys-apps/util-linux"
DEPEND=""


S=${WORKDIR}/${MY_P}

# NOTES:
# spidermonkey dep should be any javascript interpreter using /usr/bin/js

# TODO:
# dev-java/rhino could probably be an alternative for spidermonkey

src_prepare() {
	if ! use javascript; then
		sed -i -e 's:^mediafire.*::' \
			-e 's:^badongo.*::' \
			-e 's:^dataport_cz.*::' \
			-e 's:^1fichier.*::' \
			-e 's:^turbobit.*::' \
			src/modules/config || die "sed failed"
		rm src/modules/{mediafire,badongo,dataport_cz,1fichier,turbobit}.sh || die "rm failed"
	fi
	if ! use perl; then
		sed -i -e 's:^netload_in.*::' \
			-e 's:^badongo.*::' \
			src/modules/config || die "sed failed"
		rm src/modules/netload_in.sh || die "rm failed"
		if use javascript; then
			rm src/modules/badongo.sh || die "rm failed"
		fi

		# Don't install perl file helpers.
		sed -i -e 's:\(.*src/core.sh\).*:\1:' Makefile || die "sed failed"
	fi

	# Don't let 'make install' install docs.
	sed -i -e "/INSTALL.*DOCDIR/d" Makefile || die "sed failed"

	if use bash-completion; then
		sed -i -e \
			"s:CDIR=/usr/local/share/${PN}/modules/config:CDIR=/usr/share/${PN}/modules/config:" \
			etc/plowshare.completion || die "sed failed"
	fi
}

src_compile() {
	# There is a Makefile but it's not compiling anything, let's not try.
	:
}

src_test() {
	# Disable tests because all of them need a working Internet connection.
	:
}

src_install() {
	DESTDIR="${D}" PREFIX="/usr" emake install || die "emake install failed"

	dodoc AUTHORS INSTALL README || die "dodoc failed"

	if use scripts; then
		exeinto /usr/bin/
		doexe contrib/plowdown_{add_remote_loop,loop,parallel}.sh \
			|| die "doins failed"
	fi

	if use bash-completion; then
		newbashcomp etc/plowshare.completion ${PN} || die "newbashcomp failed"
	fi
}

pkg_postinst() {
	if ! use javascript; then
		ewarn "Without javascript you will not be able to use:"
		ewarn " mediafire, badongo, dataport_cz, 1fichier and turbobit."
	fi
	if ! use perl; then
		ewarn "Without perl you will not be able to use:"
		ewarn " netload.in and badongo."
	fi
}
