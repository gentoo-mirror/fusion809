# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="BitTorrent client in C++ and Qt"
HOMEPAGE="https://www.qbittorrent.org/"

SRC_URI="https://github.com/qbittorrent/qBittorrent/archive/2def21a51bdc396412b4a2eb568f6094989b1604.tar.gz"
S=${WORKDIR}/qBittorrent-2def21a51bdc396412b4a2eb568f6094989b1604

LICENSE="GPL-2"
SLOT="0"
IUSE="+dbus debug webui +X"
REQUIRED_USE="dbus? ( X )"

RDEPEND="
     >=dev-libs/boost-1.62.0-r1:=
     dev-qt/qtconcurrent:5
     dev-qt/qtcore:5
     dev-qt/qtnetwork:5[ssl]
     >=dev-qt/qtsingleapplication-2.6.1_p20130904-r1[qt5,X?]
     dev-qt/qtxml:5
     >=net-libs/libtorrent-rasterbar-1.0.6
     <=net-libs/libtorrent-rasterbar-1.0.11
     sys-libs/zlib
     dbus? ( dev-qt/qtdbus:5 )
     X? (
          dev-qt/qtgui:5
          dev-qt/qtwidgets:5
     )"
DEPEND="${RDEPEND}
     dev-qt/linguist-tools:5
     virtual/pkgconfig"

DOCS=( AUTHORS Changelog CONTRIBUTING.md README.md TODO )

src_configure() {
     local mycmakeargs=(
          -DQT5=ON
          -DSYSTEM_QTSINGLEAPPLICATION=ON
          -DDBUS=$(usex dbus)
          -DGUI=$(usex X)
          -DWEBUI=$(usex webui)
     )
     cmake-utils_src_configure
}
