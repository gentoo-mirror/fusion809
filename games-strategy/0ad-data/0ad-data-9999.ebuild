# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/0ad/0ad.git"
if [[ ${PV} == 9999* ]]; then
	GIT_ECLASS="git-r3"
fi

inherit games ${GIT_ECLASS}

MY_P=0ad-${PV/_/-}
DESCRIPTION="Data files for 0ad"
HOMEPAGE="http://wildfiregames.com/0ad/"

if [[ ${PV} == 9999* ]]; then
	SRC_URI=""
else
	SRC_URI="mirror://sourceforge/zero-ad/${MY_P}-unix-data.tar.xz"
fi

LICENSE="GPL-2 CC-BY-SA-3.0 LPPL-1.3c BitstreamVera"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="~games-strategy/0ad-${PV}[nvtt]"


S=${WORKDIR}/${MY_P}
EGIT_CHECKOUT_DIR=${S}

src_prepare() {
	default
	rm binaries/data/tools/fontbuilder/fonts/*.txt
}

src_install() {
	insinto /usr/share/0ad
	doins -r binaries/data/*
}
