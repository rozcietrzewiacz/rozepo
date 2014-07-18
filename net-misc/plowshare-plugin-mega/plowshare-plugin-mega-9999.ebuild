# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/plowshare/plowshare-20120609-r2.ebuild,v 1.1 2012/07/11 15:35:41 volkmar Exp $

### based on plowshare-20120609-r2.ebuild

EAPI="4"

inherit bash-completion-r1 autotools eutils git-2

DESCRIPTION="Command-line downloader and uploader for file-sharing websites"
HOMEPAGE="http://code.google.com/p/plowshare/"

EGIT_REPO_URI="https://code.google.com/p/plowshare.plugin-mega/"
EGIT_TREE="master"
EGIT_PROJECT="plugin-mega"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="
	net-misc/plowshare4"
DEPEND=""

# NOTES:
# spidermonkey dep should be any javascript interpreter using /usr/bin/js

# TODO:
# dev-java/rhino could probably be an alternative for spidermonkey

src_prepare() {	
	# Don't let 'make install' install docs.
	sed -i -e "/INSTALL.*DOCDIR/d" Makefile || die "sed failed"
	sed -i -e "s:/local/share:/share:" Makefile || die "sed failed"
}

src_compile() {
	#DESTDIR="${D}" PREFIX="/usr" emake || die "emake failed"
	:
}

src_test() {
	# Disable tests because all of them need a working Internet connection.
	:
}

src_install() {
	DESTDIR="${D}" PREFIX="/usr" emake install || die "emake install failed"

	dodoc README.md INSTALL || die "dodoc failed"
}

