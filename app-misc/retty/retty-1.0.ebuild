# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="A tool that lets you attach processes running on other terminals"
HOMEPAGE="http://pasky.or.cz/~pasky/dev/retty/"
SRC_URI="http://pasky.or.cz/~pasky/dev/retty/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dobin blindtty retty || die 'could not install files'
	}
