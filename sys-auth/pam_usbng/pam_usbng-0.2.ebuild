# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils # subversion

DESCRIPTION="Easy and secure authentication through ordinary USB storage devices."
HOMEPAGE="http://usbauth.delta-xi.net"
#ESVN_REPO_URI="svn://v281.ncsrv.de/svn/pam_usbng"
#ESVN_REPO_URI="svn://delta-xi.net/svn/pam_usbng"
SRC_URI="http://packages.delta-xi.net/pam_usbng-snapshot141208.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-libs/openssl
	sys-libs/pam
	sys-fs/udev"
#???	sys-apps/parted"
RDEPEND="${DEPEND}"

src_unpack()
{
	unpack "${A}"
	S=${PN}
	cd "${S}"
}
