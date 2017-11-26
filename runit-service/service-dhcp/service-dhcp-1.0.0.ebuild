# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="runit service for dhcp"
HOMEPAGE=""
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="runit-service/setupservices"
RDEPEND=">=sys-process/runit-2.1.2-r1
         net-misc/dhcp"

src_unpack() {
    mkdir -p "${S}"
}

src_install() {
    mkdir -p "${D}/etc/sv/dhclient"
    cp -a "$FILESDIR"/* "${D}/etc/sv/dhclient"
}
