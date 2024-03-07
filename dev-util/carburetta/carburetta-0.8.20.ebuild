# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An open source fused scanner parser generator for the C and C++ languages"
HOMEPAGE="https://carburetta/com"
SRC_URI="https://github.com/kingletbv/${PN}/releases/download/v${PV}/${PN}-v${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"

src_compile() {
	emake build/linux/carburetta || die
	emake || die
}

src_test() {
	emake test || die
}

src_install() {
	dobin build/linux/carburetta
}
