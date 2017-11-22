# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Service for Xorg, this runs xinit on start up"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI=""

LICENSE="GPL-3"
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
    cp -a "$FILESDIR/{run,finish}" "${D}/etc/sv/x"
    mkdir -p "${D}/usr/bin"
    cp "$FILESDIR/xinit-runit" "${D}/usr/bin/xinit-runit"
}

pkg_postinst() {
    ewarn "This package includes /usr/bin/xinit-runit,"
    ewarn "which I personally recommend you edit according"
    ewarn "to your needs. It, by default, starts X as the"
    ewarn "user with the largest home folder."
}
