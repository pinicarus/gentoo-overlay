# Copyright 2017 Pierre-Nicolas Clauss
# Distributed under the terms of the WTFPL

EAPI=6

inherit bash-completion-r1 eutils

DESCRIPTION="Framework for analysis of source codes written in C"
HOMEPAGE="http://frama-c.com"
RELEASE="${PN}-Sulfur-20171101"
SRC_URI="http://frama-c.com/download/${RELEASE}.tar.gz"
S="${WORKDIR}/${RELEASE}"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+alt-ergo +coq gtk +ocamlopt test +why3"

DEPEND=">=dev-lang/ocaml-4.02.3[ocamlopt?]
        >=dev-ml/findlib-1.6.1[ocamlopt?]
        >=dev-ml/ocamlgraph-1.8.8[gtk?,ocamlopt?]
        dev-ml/zarith[ocamlopt?]
        alt-ergo? ( sci-mathematics/alt-ergo[gtk?,ocamlopt?] )
        coq? ( sci-mathematics/coq[gtk?,ocamlopt?] )
        gtk? (
        	dev-ml/lablgtk[sourceview,gnomecanvas,ocamlopt?]
        	gnome-base/libgnomecanvas
        	x11-libs/gtksourceview:2.0
        )
        test? ( sys-process/time )"

RDEPEND="alt-ergo? ( sci-mathematics/alt-ergo[gtk?,ocamlopt?] )
         coq? ( sci-mathematics/coq[gtk?,ocamlopt?] )
         why3? ( sci-mathematics/why3-for-spark[coq?,gtk?,ocamlopt?,zarith] )"

PATCHES=( "${FILESDIR}/${PV}/missing-braces.diff" )

src_configure() {
	if use gtk; then
		econf --enable-gui
	else
		econf --disable-gui
	fi
}

src_compile() {
	emake all top
}

src_test() {
	# Create missing directories.
	mkdir --parents tests/non-free
	mkdir --parents src/plugins/e-acsl/tests/{bts,full-mmodel,gmp,no-main,reject,runtime,temporal}

	emake tests
}

src_install() {
	default
	newbashcomp "share/autocomplete_${PN}" "${PN}"
}
