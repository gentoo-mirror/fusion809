# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Service for Xorg"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI=""

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="runit-service/setupservices"
RDEPEND=">=sys-process/runit-2.1.2-r1
	x11-apps/xinit"

src_unpack() {
    mkdir -p "${S}"
}

src_install() {
    mkdir -p "${D}/etc/sv/x"
    cp -a $FILESDIR/* "${D}/etc/sv/x"
}
