# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Flat assembler"
HOMEPAGE="https://flatassembler.net"
SRC_URI="https://flatassembler.net/fasmg.k0v2.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"

DEPEND="
	dev-fasmg/xpu-ext-avx512bw
	dev-fasmg/xpu-ext-avx512cd
	dev-fasmg/xpu-ext-avx512dq
	dev-fasmg/xpu-ext-avx512f
	dev-fasmg/xpu-ext-avx512vl
	dev-fasmg/xpu-ext-avx512_ifma
	dev-fasmg/xpu-ext-avx512_vbmi
"
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
	cp examples/x86/include/ext/avx512.inc "${T}"
	dos2unix "${T}/avx512.inc"
}

src_install () {
	insinto /usr/include/fasmg/xpu/intel/ext
	doins "${T}/avx512.inc"
}
