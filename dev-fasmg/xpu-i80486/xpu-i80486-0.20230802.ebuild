# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

FASMG_MODULE_INSINTO=xpu/intel
FASMG_MODULE_FILES=(
	examples/x86/include/80486.inc
)

inherit fasmg-module

DESCRIPTION="Flat assembler"
HOMEPAGE="https://flatassembler.net"
SRC_URI="https://flatassembler.net/fasmg.k4v8.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"

DEPEND="dev-fasmg/xpu-i80386"
RDEPEND="${DEPEND}"
BDEPEND=""
