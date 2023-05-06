# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Flat assembler"
HOMEPAGE="https://flatassembler.net"
SRC_URI="https://flatassembler.net/fasmg.k0v2.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	app-arch/unzip
	app-text/dos2unix
"

src_unpack () {
	mkdir "${S}"
	pushd "${S}"
	unpack "${A}"
	popd
}

src_compile () {
	cp examples/8051/hex.inc "${T}"
	dos2unix "${T}/hex.inc"
}

src_install () {
	insinto /usr/include/fasmg/fmt
	doins "${T}/hex.inc"
}
