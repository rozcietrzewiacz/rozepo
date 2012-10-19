# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /cvsroot/ultrastar-ng/UltraStar-ng/portage-overlay/games-arcade/performous/performous-9999.ebuild,v 1.10 2007/09/29 13:04:19 yoda-jm Exp $

EAPI=3

inherit games cmake-utils

RESTRICT="nostrip"

MY_PN=Performous
MY_P=${MY_PN}-${PV}-Source
SONGS_PN=ultrastar-songs

DESCRIPTION="Karaoke game similar to Singstar"
HOMEPAGE="http://performous.org"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2
	songs? ( 
		mirror://sourceforge/${PN}/${SONGS_PN}-jc-1.zip
		mirror://sourceforge/${PN}/${SONGS_PN}-libre-3.zip
		mirror://sourceforge/${PN}/${SONGS_PN}-restricted-3.zip
		mirror://sourceforge/${PN}/${SONGS_PN}-shearer-1.zip
	)"

LICENSE="GPL-2
	songs? (
		CCPL-Attribution-ShareAlike-NonCommercial-2.5
		CCPL-Attribution-NonCommercial-NoDerivs-2.5
	)"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~ppc64"

IUSE="debug alsa portaudio pulseaudio jack songs gstreamer"

RDEPEND="gnome-base/librsvg
	dev-libs/boost
	x11-libs/pango
	dev-cpp/libxmlpp
	media-libs/libsdl[joystick,opengl]
	media-gfx/imagemagick
	(
		virtual/opengl
		virtual/glu
	)
	>=media-video/ffmpeg-0.4.9_p20070616-r20
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )
	portaudio? ( media-libs/portaudio )
	gstreamer? ( media-libs/gstreamer )
	pulseaudio? ( media-sound/pulseaudio )
	sys-apps/help2man
	!games-arcade/ultrastar-ng"
DEPEND="${RDEPEND}
    >=dev-util/cmake-2.6.0"

pkg_setup() {
	games_pkg_setup
	if ! built_with_use --missing true dev-libs/boost threads ; then
		eerror "Please emerge dev-libs/boost with USE=threads"
	fi
}

src_unpack() {
	unpack "${MY_P}.tar.bz2"
	mv "${MY_P}" "${P}"
	if use songs; then
		cd "${S}"
		unpack "${SONGS_PN}-jc-1.zip"
		unpack "${SONGS_PN}-libre-3.zip"
		unpack "${SONGS_PN}-restricted-3.zip"
		unpack "${SONGS_PN}-shearer-1.zip"
	fi
}

src_compile() {
	mkdir build
	cd build
	plugins="-DLIBDA_AUTODETECT_PLUGINS=false -DLIBDA_PLUGIN_TESTING=false"
	if use alsa ; then
		plugins="$plugins -DLIBDA_PLUGIN_ALSA=true"
	else
		plugins="$plugins -DLIBDA_PLUGIN_ALSA=false"
	fi
	if use jack ; then
		plugins="$plugins -DLIBDA_PLUGIN_JACK=true"
	else
		plugins="$plugins -DLIBDA_PLUGIN_JACK=false"
	fi
	if use gstreamer ; then
		plugins="$plugins -DLIBDA_PLUGIN_GSTREAMER=true"
	else
		plugins="$plugins -DLIBDA_PLUGIN_GSTREAMER=false"
	fi
	if use portaudio ; then
		plugins="$plugins -DLIBDA_PLUGIN_PORTAUDIO=true"
	else
		plugins="$plugins -DLIBDA_PLUGIN_PORTAUDIO=false"
	fi
	if use pulseaudio ; then
		plugins="$plugins -DLIBDA_PLUGIN_PULSE=true"
	else
		plugins="$plugins -DLIBDA_PLUGIN_PULSE=false"
	fi
	cmake \
		-DCMAKE_CXX_FLAGS="${CXXFLAGS}" \
		-DCMAKE_INSTALL_PREFIX="/usr" \
		$plugins \
		.. || die "cmake failed"
	emake || die "emake failed"
}

src_install() {
	cd build
	emake DESTDIR="${D}" install || die "make install failed"
	keepdir "/usr/ultrastar/songs"
	rm -rf "${D}/usr/share/${PN}"/{applications,pixmaps}
	if use songs; then
		insinto "/usr/share/games/ultrastar"
		doins -r ../songs || die "doins songs failed"
	fi
	doicon data/${PN}.xpm
	domenu data/${PN}.desktop
	dodoc ../docs/*.txt
	prepgamesdirs
}
