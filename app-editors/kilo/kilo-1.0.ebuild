# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A text editor in less than 1000 LOC with syntax highlight and search."
HOMEPAGE="https://github.com/antirez/kilo"
SRC_URI="https://github.com/antirez/kilo/archive/62b099af00b542bdb08471058d527af258a349cf.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S=${WORKDIR}/kilo-62b099af00b542bdb08471058d527af258a349cf

src_install() {
    dobin kilo
}
