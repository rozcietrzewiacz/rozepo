# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit bzr distutils

EBZR_REPO_URI="lp:gdm2setup"

DESCRIPTION="GDM management utility"
HOMEPAGE="https://launchpad.net/gdm2setup"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="gnome-base/gdm
	dev-python/setuptools"
DEPEND="${RDEPEND}"
