# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit distutils

# package series
PVS="0.2"

MY_PV="0.5.3-lucid"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="GDM management utility"
HOMEPAGE="https://launchpad.net/gdm2setup"
SRC_URI="http://launchpad.net/gdm2setup/${PVS}/${PV}/+download/${PN}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="gnome-base/gdm
	dev-python/setuptools"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"
