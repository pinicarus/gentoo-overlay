# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Standard library for the C3 programming language"
HOMEPAGE="https://c3-lang.org/"
SRC_URI="https://github.com/c3lang/c3c/archive/refs/tags/v${PV}.tar.gz -> c3-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
IUSE=""
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="=dev-lang/c3-${PV}"
BDEPEND=""

S="${WORKDIR}/c3c-${PV}"

src_install() {
	insinto /usr/lib/c3
	doins -r lib/std
}
