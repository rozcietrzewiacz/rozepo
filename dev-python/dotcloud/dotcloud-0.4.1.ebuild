# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit distutils

MY_P="${PN}.cli-${PV}"
DESCRIPTION="dotCloud command-line interface client"
HOMEPAGE="http://www.dotcloud.com/"
SRC_URI="mirror://pypi/d/dotcloud.cli/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"
