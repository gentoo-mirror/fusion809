# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python{3_2,3_3,3_4} )
inherit distutils-r1

DESCRIPTION="Colour representations manipulation library (RGB, HSL, web, ...)"
HOMEPAGE="https://github.com/vaab/colour"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/d2to1"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
