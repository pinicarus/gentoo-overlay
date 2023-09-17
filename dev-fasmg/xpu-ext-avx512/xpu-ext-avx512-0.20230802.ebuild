# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

FASMG_MODULE_INSINTO=xpu/intel/ext
FASMG_MODULE_FILES=(
	examples/x86/include/ext/avx512.inc
)

inherit fasmg-module

DESCRIPTION="Flat assembler"
HOMEPAGE="https://flatassembler.net"
SRC_URI="https://flatassembler.net/fasmg.k4v8.zip"

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
BDEPEND=""
