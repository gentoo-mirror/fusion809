# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

WX_GTK_VER="3.0"
inherit cmake-utils wxwidgets

DESCRIPTION="A Free, open source, cross platform C, C++, PHP and Node.js IDE"
HOMEPAGE="https://www.codelite.org"
SRC_URI="https://github.com/eranif/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="clang lldb mysql sftp valgrind"

DEPEND="
	net-libs/libssh
	x11-libs/wxGTK:3.0
	mysql? ( virtual/mysql )
	valgrind? ( dev-util/valgrind )
"

RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
	-Ddocdir="${EPREFIX}/usr/share/doc/${PF}"
	-DCMAKE_INSTALL_LIBDIR=lib ..
	-DENABLE_CLANG="$(usex clang)"
	-DENABLE_LLDB="$(usex lldb)"
	-DENABLE_MYSQL="$(usex mysql)"
	-DENABLE_SFTP="$(usex sftp)"
	)

	cmake-utils_src_configure
}
