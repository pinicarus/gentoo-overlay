# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A task runner that aims to be simpler and easier to use than make"
HOMEPAGE="https://taskfile.dev/"
SRC_URI="
	https://github.com/go-task/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/pinicarus/gentoo-overlay-files/releases/download/${P}/${P}-vendor.tar.xz
"

LICENSE="
	BSD
	BSD-2
	ISC
	MIT
"
SLOT="0"
KEYWORDS="amd64"
IUSE="debug static"

BDEPEND=">=dev-lang/go-1.22"

src_compile() (
	local ldflags=(
		"-X=github.com/go-task/task/v3/internal/version.version=${PV}"
	)
	use static && ldflags+=("-extldflags=-static")
	use debug  || ldflags+=("-s" "-w")

	export CGO_ENABLED=$(usex static 0 1)
	ego build -buildmode=exe -buildvcs=false -trimpath -ldflags="${ldflags[*]}" ./cmd/task || die
	use debug || strip task
)

src_install() {
	dobin task
}
