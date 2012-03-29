# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit latex-package

DESCRIPTION="LaTeX class for creating conference posters, based on Beamer."
HPBASEURI="http://www-i6.informatik.rwth-aachen.de/~dreuw/"
HOMEPAGE="${HPBASEURI}/latexbeamerposter.php"
STYSRC="${PN}.sty.${PV}"
DLBASEURI="${HPBASEURI}/download/"
SRC_URI="${DLBASEURI}/${STYSRC}
	${DLBASEURI}/beamerthemeIcy.sty
	${DLBASEURI}/beamerthemeAachen.sty
	${DLBASEURI}/beamerthemeI6pd.sty
	${DLBASEURI}/beamerthemeI6pd2.sty
	${DLBASEURI}/beamerthemeI6dv.sty
	${DLBASEURI}/beamerthemeI6td.sty
	examples? ( ${DLBASEURI}/beamerposter-example.zip
				${DLBASEURI}/beamerposter-example2.zip
				${DLBASEURI}/beamerposter-example3.zip
				${DLBASEURI}/dreuw07-interspeech.tex
				${DLBASEURI}/dreuw08-lrec.tex
				${DLBASEURI}/example-style-I6ac.tex
				${DLBASEURI}/example-style-I6pd.tex
				${DLBASEURI}/example-style-I6pd2.tex
				${DLBASEURI}/example-style-I6dv.tex
				${DLBASEURI}/example-style-I6td.tex )"
THEMES="beamerthemeIcy.sty 
		beamerthemeAachen.sty 
		beamerthemeI6pd.sty 
		beamerthemeI6pd2.sty 
		beamerthemeI6dv.sty 
		beamerthemeI6td.sty"
EXAMPLES="beamerposter-example.zip 
		beamerposter-example2.zip 
		beamerposter-example3.zip 
		dreuw07-interspeech.tex 
		dreuw08-lrec.tex 
		example-style-I6pd.tex 
		example-style-I6pd2.tex 
		example-style-I6dv.tex 
		example-style-I6td.tex"


# License versions not specified in source file
LICENSE="GPL LPPL"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"

IUSE="examples"
DEPEND=""
#
# Beamerposter requires the beamer, type1cm, paralist, 
# fp and xkeyval LaTeX packages.  Aachen and I6pd2 themes
# also require the tangocolors package.
#
# * latex-beamer gives beamer 
#
# * texlive-latexextra gives type1cm and paralist 
#
# * fp and xkeyval are in texlive-latexrecommended, which is
#   required by the texlive meta-package, which is required by
#   the latex-package eclass
#
# * tangocolors is license-comptabile; we put it in the files dir.
#
RDEPEND="dev-tex/latex-beamer
		dev-texlive/texlive-latexextra"

src_install() {
	cd ${T}
	insinto /usr/share/texmf-site/tex/latex/beamerposter
	# beamerposter package
	STYINS="${PN}.sty"
	cp "${DISTDIR}/${STYSRC}" "${STYINS}"
	doins "${STYINS}" || die "could not install package"

	# themes
	insinto "/usr/share/doc/${PF}/themes"
	for theme in ${THEMES}; do
		doins "${DISTDIR}/${theme}" || die "could not install theme"
	done
	# tangocolors, needed for Aachen and I6pd2 themes
	doins "${FILESDIR}/tangocolors.sty" || die "could not install package"
	# examples
	if use examples; then
		insinto "/usr/share/doc/${PF}/examples"
		for ex in ${EXAMPLES}; do
			doins "${DISTDIR}/${ex}" || die "could not install example"
		done
	fi
}

pkg_postinst() {
	einfo "Look in /usr/share/doc/${PF} for themes and examples."
	einfo "To use a theme, copy it to your document directory and"
	einfo "modify it with your own information."
}
