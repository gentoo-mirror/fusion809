# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# =DvD= @ Gentoo Forum's fix for VirtualBox 5.1.20 issues
# Per https://forums.gentoo.org/viewtopic-p-8060386.html

EAPI=6

inherit eutils linux-mod user

MY_P=vbox-kernel-module-src-${PV}
DESCRIPTION="Kernel Modules for Virtualbox"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="https://www.virtualbox.org/download/testcase/VirtualBox-5.1.21-115049-Linux_amd64.run"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pax_kernel"

RDEPEND="=app-emulation/virtualbox-bin-${PV}"

S=${WORKDIR}

BUILD_TARGETS="all"
BUILD_TARGET_ARCH="${ARCH}"
MODULE_NAMES="vboxdrv(misc:${S}) vboxnetflt(misc:${S}) vboxnetadp(misc:${S}) vboxpci(misc:${S})"

pkg_setup() {
	enewgroup vboxusers

	CONFIG_CHECK="!TRIM_UNUSED_KSYMS"
	ERROR_TRIM_UNUSED_KSYMS="The kernel option CONFIG_TRIM_UNUSED_KSYMS removed kernel symbols that are needed by ${PN} to load correctly."

	linux-mod_pkg_setup

	BUILD_PARAMS="KERN_DIR=${KV_DIR} O=${KV_OUT_DIR} V=1 KBUILD_VERBOSE=1"
}

src_unpack() {
	cd ${T}
	bash ${DISTDIR}/${A} --keep --noexec
	cd install
	tar -xjvf VirtualBox.tar.bz2 src
	mv src/vboxhost/* ${WORKDIR}
}




src_prepare() {
	if kernel_is -ge 2 6 33 ; then
		# evil patch for new kernels - header moved
		grep -lR linux/autoconf.h *  | xargs sed -i -e 's:<linux/autoconf.h>:<generated/autoconf.h>:'
	fi

	if use pax_kernel && kernel_is -ge 3 0 0 ; then
		epatch "${FILESDIR}"/${PN}-4.1.4-pax-const.patch
	fi

	default
}

src_install() {
	linux-mod_src_install
	insinto /usr/lib/modules-load.d/
	doins "${FILESDIR}"/virtualbox.conf
}

pkg_postinst() {
	linux-mod_pkg_postinst
	elog "If you are using sys-apps/openrc, please add \"vboxdrv\", \"vboxnetflt\","
	elog "\"vboxnetadp\" and \"vboxpci\" to:"
	elog "  /etc/conf.d/modules"
}
