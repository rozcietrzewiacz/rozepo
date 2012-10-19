# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
PYTHON_DEPEND="2"

inherit distutils eutils

DESCRIPTION="Taskhelm is a graphical interface for taskwarrior (app-misc/task)."
HOMEPAGE="http://taskwarrior.org/projects/taskwarrior/wiki/Taskhelm"
SRC_URI="http://www.bryceharrington.org/files/${P}.tar.gz"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="app-misc/task dev-python/pygtk virtual/perl-JSON-PP dev-python/pygobject"
RDEPEND="${DEPEND}"

DOCS="README"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}


src_install() {
	distutils_src_install
}
