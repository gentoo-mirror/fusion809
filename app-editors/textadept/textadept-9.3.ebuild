# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

S="${WORKDIR}/${PN}-${PN}_${PV}"

SRC_URI="\
	http://foicica.com/hg/${PN}/archive/${PN}_${PV}.zip
	http://foicica.com/scintillua/download/scintillua_3.7.3-1.zip -> scintillua_3.7.3-1.zip \
	http://foicica.com/hg/bombay/archive/tip.zip -> bombay.zip \
	http://foicica.com/gtdialog/download/gtdialog_1.3.zip \
	http://foicica.com/lspawn/download/lspawn_1.5.zip \
	http://foicica.com/scinterm/download/scinterm_1.8.zip \
	http://prdownloads.sourceforge.net/scintilla/scintilla373.tgz \
	http://github.com/keplerproject/luafilesystem/archive/v_1_6_3.zip \
	http://invisible-mirror.net/archives/cdk/cdk-5.0-20150928.tgz \
	http://www.inf.puc-rio.br/~roberto/lpeg/lpeg-1.0.0.tar.gz \
	http://www.lua.org/ftp/lua-5.3.4.tar.gz \
	http://www.leonerd.org.uk/code/libtermkey/libtermkey-0.17.tar.gz \
	https://github.com/starwing/luautf8/archive/0.1.1.zip \
	http://luajit.org/download/LuaJIT-2.0.3.tar.gz"
	
KEYWORDS="~amd64 ~x86"

DESCRIPTION="A fast, minimalist, and remarkably extensible cross-platform text editor"
HOMEPAGE="http://foicica.com/${PN}/"

LANGS=" ar de es fr it pl ru sv"
IUSE="gtk gtk3 luajit ncurses ${LANGS// / l10n_}"
REQUIRED_USE="|| ( ncurses gtk )
	gtk3? ( gtk )"

LICENSE="MIT"

RDEPEND="gtk? ( x11-libs/gtk+:2 )
	ncurses? ( sys-libs/ncurses )"

DEPEND="${RDEPEND}
	app-arch/unzip"
SLOT="0"

src_unpack() {
	maindistfile="${PN}_${PV}.zip"
	unpack "${maindistfile}"
	for distfile in ${A}; do
		if [ "${distfile}" != "${maindistfile}" ]; then
			cp "${DISTDIR}/${distfile}" "${S}/src/"
		fi
	done
}

src_prepare() {
	cd src
	sed -i '
		/^#/ d
		/Categories=/ s/$/;/
		/Icon=/ s/\.svg$//
		' *.desktop || die
	sed -i '
		1iunexport LDFLAGS
		s/CFLAGS = -Os/CFLAGS += -Os/g
		s/CXXFLAGS = -Os /CXXFLAGS += -Os /g
		s/LDFLAGS = /LDFLAGS += /g
		' Makefile || die
	emake -j1 deps
	cd -
	epatch_user
}

src_compile() {
	cd src
	use luajit  && luajit_suffix="jit"
	use gtk3    && export GTK3=1
	use gtk     && emake ${PN}${luajit_suffix}
	use ncurses && emake ${PN}${luajit_suffix}-curses
}

src_install() {
	doicon -s scalable core/images/${PN}.svg
	use gtk     && domenu src/${PN}.desktop
	use ncurses && domenu src/${PN}-curses.desktop
	dodoc LICENSE
	rm core/images/{textadept.*,*.ico}
	home=/usr/share/${PN}
	insinto ${home}
	for lingua in $LANGS; do
		if ! use l10n_${lingua}; then
			rm core/locales/locale.${lingua}.conf
		fi
	done
	rmdir --ignore-fail-on-non-empty core/locales
	doins -r core lexers modules themes *.lua
	find ${D} -type f \( -name '.*' -o -name '*.cxx' -o -name '*.luadoc' -o -name '*.patch' \) -delete
	exeinto ${home}
	for binfile in ${PN}*; do
		doexe ${binfile}
		dosym ../share/${PN}/${binfile} /usr/bin/${binfile/jit/}
	done
}
