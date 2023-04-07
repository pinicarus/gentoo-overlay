# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Framework for analysis of source codes written in C"
HOMEPAGE="http://frama-c.com"
RELEASE="${P}-Iron"
SRC_URI="http://frama-c.com/download/${RELEASE}.tar.gz"
S="${WORKDIR}/${RELEASE}"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gtk +ocamlopt"

BDEPEND="
	>=dev-lang/ocaml-4.11.1[ocamlopt?]
	>=dev-ml/dune-3.2.0
	dev-ml/dune-configurator[ocamlopt?]
	dev-ml/dune-private-libs[ocamlopt?]
	dev-ml/dune-site[ocamlopt?]
	dev-ml/ppx_deriving[ocamlopt?]
	dev-ml/ppx_deriving_yojson[ocamlopt?]
	dev-ml/ppx_import[ocamlopt?]
	dev-ml/findlib[ocamlopt?]
	>=dev-ml/ocamlgraph-1.8.8[ocamlopt?]
	>=dev-ml/result-1.5[ocamlopt?]
	>=dev-ml/yojson-1.6.0[ocamlopt?]
	<dev-ml/yojson-2.0.0[ocamlopt?]
	>=dev-ml/zarith-1.5[ocamlopt?]
"
DEPEND="
	sci-mathematics/alt-ergo[ocamlopt?]
	>=sci-mathematics/why3-1.5.1[gtk?,ocamlopt?,zarith]
	<sci-mathematics/why3-1.6.0[gtk?,ocamlopt?,zarith]
	gtk? (
		>=dev-ml/cairo2-0.6.2[ocamlopt?]
		>=dev-ml/lablgtk-3.1.0[ocamlopt?]
		dev-ml/lablgtk-sourceview[ocamlopt?]
		x11-libs/gtksourceview:3.0
	)
"
RDEPEND=""

src_compile() {
	emake RELEASE=yes
}

src_test() {
	# Remote test that cannot run in the ebuild sandbox.
	rm -f tests/fc_script/make-wrapper.c
	sed -i -e 's|^ DEPS: @PTEST_DEPS@ ./make-wrapper.c$||' tests/fc_script/list_functions.i
	sed -i -e 's| make-wrapper.c||' tests/fc_script/main.c
	sed -i -e '/^make-wrapper.c:/d' tests/fc_script/oracle/heuristic_list_functions.res
	sed -i -e 's|15 file(s)|14 file(s)|' tests/fc_script/oracle/find_fun{1,2,3}.res

	emake run-ptests
	emake default-tests
}

src_install() {
	emake install PREFIX=/usr DESTDIR="${D}"
	mv "${D}"/usr/lib{,64}
	mv "${D}"/usr/{,share/${PN}/}doc
	mv "${D}"/usr/{,share/}man
}
