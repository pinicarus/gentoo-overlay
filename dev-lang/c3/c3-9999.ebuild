# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

PYTHON_COMPAT=( python3_{8,9,10,11,12} )
inherit python-any-r1

DESCRIPTION="A system programming language based on C"
HOMEPAGE="https://c3-lang.org/"

EGIT_MIN_CLONE_TYPE="shallow"
EGIT_REPO_URI="https://github.com/c3lang/c3c.git"
EGIT_BRANCH="master"
inherit git-r3

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="sys-devel/llvm"
RDEPEND="${DEPEND}"
BDEPEND="test? ( ${PYTHON_DEPS} )"

PATCHES=(
	"${FILESDIR}/CMakeLists.diff"
)

src_unpack () {
	git-r3_src_unpack
}

src_test () (
	C3C=$(realpath --canonicalize-existing --relative-to="${PWD}" "${BUILD_DIR}/c3c")
	python3 test/src/tester.py "${C3C}" test/test_suite || die
)

src_install() {
	into /usr
	dobin "${BUILD_DIR}/c3c"
	dolib.a "${BUILD_DIR}/libc3c_wrappers.a"
	dolib.a "${BUILD_DIR}/libminiz.a"
}
