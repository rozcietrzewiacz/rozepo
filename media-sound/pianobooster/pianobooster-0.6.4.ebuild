# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils

MY_P=${PN}-src-${PV}

DESCRIPTION="A score reading / midi typing tutor"
HOMEPAGE="http://pianobooster.sourceforge.net"
SRC_URI="http://downloads.sourceforge.net/project/${PN}/${PN}/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="media-libs/alsa-lib
	sys-libs/glibc
	virtual/opengl
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4"

RDEPEND="${DEPEND}"

DOCS="ReleaseNote.txt ../README.txt"

S=${WORKDIR}/${MY_P}/src

src_prepare() {
	sed -i -e "/README.txt/d" \
		CMakeLists.txt || die "sed failed"
	default
}
