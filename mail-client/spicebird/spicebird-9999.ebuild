# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit eutils autotools multilib mercurial

DESCRIPTION=""
HOMEPAGE="http://www.spicebird.com"
#SRC_URI="https://code.spicebird.org/hg/spicebird-central/archive/tip.tar.bz2"
EHG_REPO_URI="https://code.spicebird.org/hg/spicebird-central"

LICENSE="|| ( MPL-1.1 GPL-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""


DEPEND=""
RDEPEND="x11-libs/libXrender
	x11-libs/libXt
	x11-libs/libXmu
		>=x11-libs/gtk+-2.2
		=virtual/libstdc++-3.3
		media-libs/libart_lgpl
		gnome-base/libbonoboui
		gnome-base/orbit:2
		gnome-base/libgnomeui
		gnome-base/gnome-keyring
	"


#src_unpack(){
#	unpack ${A}
#	cd ${WORKDIR}/spicebird-central-*
#	S="`pwd`"
#	#wget "http://www.spicebird.com/pub/mozilla/mozilla_TAG_THUNDERBIRD_3_0a2_RELEASE.tar.bz2"
#	#tar jxf "mozilla_TAG_THUNDERBIRD_3_0a2_RELEASE.tar.bz2"
#}


src_prepare(){
	eautoconf || die "DUUUUuppa"
}

#src_configure(){
#	cd "${S}"
#}

#src_compile()
#{
#	cd "${S}"
#	make -f client.mk build
#}
