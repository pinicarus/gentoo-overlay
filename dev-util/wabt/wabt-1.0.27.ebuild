# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The WebAssembly Binary Toolkit"
HOMEPAGE="https://github.com/WebAssembly/wabt"
SRC_URI="https://github.com/WebAssembly/${PN}/releases/download/${PV}/${P}.tar.xz"

inherit cmake

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="clang"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND+=" clang? ( sys-devel/clang:13 )"

src_configure () {
	local mycmakeargs=(
		"-Wno-dev"
		"-DCMAKE_BUILD_TYPE=Release"
	)
	if use clang; then
		mycmakeargs+=(
			"-DCMAKE_C_COMPILER=clang"
			"-DCMAKE_CXX_COMPILER=clang++"
		)
	else
		mycmakeargs+=(
			"-DCMAKE_C_COMPILER=gcc"
			"-DCMAKE_CXX_COMPILER=g++"
		)
	fi
	cmake_src_configure || die
}

src_test () {
	test/run-tests.py || die
}
