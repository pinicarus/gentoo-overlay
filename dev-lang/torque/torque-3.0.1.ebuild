# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	equivalent@1.0.2
	hashbrown@0.15.2
	indexmap@2.7.1
	paste@1.0.15
	termcolor@1.4.1
	winapi-util@0.1.9
	windows-targets@0.52.6
	windows-sys@0.59.0
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_msvc@0.52.6
"

RUST_MIN_VER="1.85.0"

inherit cargo rust-toolchain

BENBRIDLE_CRATES=(
	"assembler   2.3.0"
	"inked       1.0.0"
	"log         1.1.1 2.0.0"
	"switchboard 2.1.0"
	"vagabond    1.1.1"
)

for crate in "${!BENBRIDLE_CRATES[@]}"; do
	if read -r name versions < <(echo "${BENBRIDLE_CRATES[${crate}]}"); then
		for version in ${versions}; do
			CARGO_CRATE_URIS+=" https://code.benbridle.com/${name}/snapshot/${name}-${version}.zip"
		done
	fi
done

DESCRIPTION="Lightweight meta-assembler"
HOMEPAGE="https://benbridle.com/projects/torque"
SRC_URI="https://code.benbridle.com/${PN}-asm/snapshot/${PN}-asm-${PV}.zip"
SRC_URI+=" ${CARGO_CRATE_URIS}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-asm-${PV}"

src_unpack() {
	cargo_src_unpack

	for crate in "${!BENBRIDLE_CRATES[@]}"; do
		if read -r name versions < <(echo "${BENBRIDLE_CRATES[${crate}]}"); then
			printf -- "[patch.'git://benbridle.com/%s']\n" "${name}"
			for version in ${versions}; do
				printf -- '"%s:%s" = { path = "%s", package = "%s", version = "%s" }\n' "${name}" "${version}" "${WORKDIR}/${name}-${version}" "${name}" "${version}"
			done
		fi
	done >> "${WORKDIR}/cargo_home/config.toml"
}

src_install() {
	dobin target/release/tq
}
