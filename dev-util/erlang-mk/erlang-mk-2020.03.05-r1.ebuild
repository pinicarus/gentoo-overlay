# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ERL_MK="${PN//-/.}"
DESCRIPTION="A build tool for Erlang that just works."
HOMEPAGE="https://github.com/ninenines/${ERL_MK}"
SRC_URI="https://github.com/ninenines/${ERL_MK}/archive/${PV}.tar.gz -> ${ERL_MK}-${PV}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="asciidoc"

DEPEND=""
BDEPEND=">=sys-devel/make-4"
RDEPEND="${BDEPEND}
        asciidoc? (
        	>=app-text/asciidoc-9.0.2
        	>=app-text/dblatex-0.3.11
        	>=dev-libs/libxslt-1.1.34
        )"

S="${WORKDIR}/${ERL_MK}-${PV}"

src_compile() {
	emake
}

src_install() {
	doheader erlang.mk

	dodoc -r doc/src/guide
}
