# Distributed under the terms of the GNU General Public License v2

EAPI=6
MY_PN=${PN/-bin/}

DESCRIPTION="Brave web browser for laptops and desktops (binary)"
HOMEPAGE="https://www.brave.com"
SRC_URI="https://www.github.com/${MY_PN}/browser-laptop/releases/download/v${PV}dev/Brave.tar.bz2"

KEYWORDS="~amd64 ~x86"

LICENSE="MPL-2.0"
SLOT="0"
IUSE=""

#RDEPEND=">=net-libs/nodejs-6.1
#     dev-util/electron
RDEPEND="
     gnome-base/libgnome-keyring"
DEPEND="${RDEPEND}"

S="${WORKDIR}/Brave-linux-x64"

src_install() {
     insinto /usr/share/applications
     doins ${FILESDIR}/${MY_PN}.desktop

     insinto /usr/share/pixmaps
     doins ${FILESDIR}/${MY_PN}.png

     insinto /usr/share/${MY_PN}
     doins version *.pak *.bin *.dat

     doins -r resources locales

     exeinto /usr/share/${MY_PN}
     doexe ${MY_PN}
     dosym /usr/share/${MY_PN}/${MY_PN} /usr/bin/${MY_PN}
}
