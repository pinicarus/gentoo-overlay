# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A standalone runtime for WebAssembly"
HOMEPAGE="https://github.com/bytecodealliance/wasmtime"

# Filed https://github.com/bytecodealliance/wasmtime/issues/3808 upstream
WASI_HASH=8a381fb9124b3aca29755ce8e255d2eeaddb16cb
WASI_CRYPTO_HASH=b079865e82fd07ae45c5e75391a76ccac2e7d436
WASI_NN_HASH=d681fa27331a25891c1314b4ca7bca0c873cc119

SRC_URI="
	https://github.com/bytecodealliance/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/WebAssembly/WASI/archive/${WASI_HASH}.zip -> wasi-${WASI_HASH}.zip
	https://github.com/WebAssembly/wasi-crypto/archive/${WASI_CRYPTO_HASH}.zip -> wasi-crypto-${WASI_CRYPTO_HASH}.zip
	https://github.com/WebAssembly/wasi-nn/archive/${WASI_NN_HASH}.zip -> wasi-nn-${WASI_NN_HASH}.zip
"

CRATES="
	addr2line-0.17.0
	adler-1.0.2
	aead-0.4.3
	aes-0.7.5
	aes-gcm-0.9.4
	ahash-0.4.7
	aho-corasick-0.7.18
	ambient-authority-0.0.1
	ansi_term-0.11.0
	ansi_term-0.12.1
	anyhow-1.0.40
	arbitrary-1.0.1
	async-trait-0.1.51
	atty-0.2.14
	autocfg-0.1.7
	autocfg-1.0.1
	backtrace-0.3.63
	base64-0.13.0
	base64ct-1.1.0
	bincode-1.3.3
	bindgen-0.59.1
	bit-set-0.5.2
	bit-vec-0.6.3
	bitflags-1.3.2
	bitvec-0.19.5
	block-buffer-0.9.0
	bstr-0.2.16
	bumpalo-3.7.0
	byteorder-1.4.3
	bytes-1.0.1
	cap-fs-ext-0.24.0
	cap-primitives-0.24.0
	cap-rand-0.24.0
	cap-std-0.24.0
	cap-tempfile-0.24.0
	cap-time-ext-0.24.0
	capstone-0.9.0
	capstone-sys-0.13.0
	cast-0.2.7
	cc-1.0.72
	cexpr-0.5.0
	cfg-if-0.1.10
	cfg-if-1.0.0
	chacha20-0.8.1
	chacha20poly1305-0.9.0
	cipher-0.3.0
	clang-sys-1.2.0
	clap-2.33.3
	cmake-0.1.45
	console-0.14.1
	const-oid-0.6.1
	cpp_demangle-0.3.2
	cpufeatures-0.2.1
	crc32fast-1.2.1
	criterion-0.3.5
	criterion-plot-0.4.4
	crossbeam-channel-0.5.1
	crossbeam-deque-0.8.1
	crossbeam-epoch-0.9.5
	crossbeam-utils-0.8.5
	crypto-bigint-0.2.10
	crypto-mac-0.11.1
	csv-1.1.6
	csv-core-0.1.10
	ctr-0.8.0
	cty-0.2.1
	curve25519-dalek-3.1.0
	der-0.4.4
	derivative-2.2.0
	derive_arbitrary-1.0.1
	digest-0.9.0
	directories-next-2.0.0
	dirs-next-2.0.0
	dirs-sys-next-0.1.2
	downcast-rs-1.2.0
	ecdsa-0.12.4
	ed25519-1.1.1
	ed25519-dalek-1.0.1
	either-1.6.1
	elliptic-curve-0.10.6
	encode_unicode-0.3.6
	env_logger-0.7.1
	env_logger-0.8.3
	env_logger-0.9.0
	errno-0.2.8
	errno-dragonfly-0.1.1
	fallible-iterator-0.2.0
	ff-0.10.1
	file-per-thread-logger-0.1.4
	filecheck-0.5.0
	filetime-0.2.14
	fnv-1.0.7
	fs-set-times-0.15.0
	fslock-0.1.7
	funty-1.1.0
	gcc-0.3.55
	generic-array-0.14.4
	getrandom-0.1.16
	getrandom-0.2.3
	ghash-0.4.4
	gimli-0.26.1
	glob-0.3.0
	group-0.10.0
	half-1.7.1
	hashbrown-0.9.1
	heck-0.3.3
	hermit-abi-0.1.18
	hermit-abi-0.2.0
	hkdf-0.11.0
	hmac-0.11.0
	humantime-1.3.0
	humantime-2.1.0
	id-arena-2.2.1
	indexmap-1.6.2
	indicatif-0.13.0
	instant-0.1.9
	io-extras-0.13.2
	io-lifetimes-0.5.1
	ipnet-2.3.0
	is-terminal-0.1.0
	is_ci-1.1.1
	itertools-0.10.0
	itoa-0.4.7
	itoa-1.0.1
	ittapi-rs-0.1.6
	jobserver-0.1.22
	js-sys-0.3.51
	k256-0.9.6
	lazy_static-1.4.0
	lazycell-1.3.0
	leb128-0.2.4
	libc-0.2.116
	libfuzzer-sys-0.4.2
	libloading-0.7.0
	libm-0.2.1
	linux-raw-sys-0.0.37
	listenfd-0.3.5
	lock_api-0.4.4
	log-0.4.14
	mach-0.3.2
	maybe-owned-0.3.4
	memchr-2.4.1
	memfd-0.4.1
	memmap2-0.2.3
	memoffset-0.6.4
	memory_units-0.3.0
	miette-3.2.0
	miette-derive-3.2.0
	miniz_oxide-0.4.4
	mio-0.7.11
	miow-0.3.7
	more-asserts-0.2.1
	nix-0.23.0
	nom-6.1.2
	ntapi-0.3.6
	num-bigint-0.2.6
	num-bigint-dig-0.7.0
	num-integer-0.1.44
	num-iter-0.1.42
	num-rational-0.2.4
	num-traits-0.2.14
	num_cpus-1.13.0
	number_prefix-0.3.0
	object-0.27.0
	ocaml-boxroot-sys-0.2.0
	ocaml-interop-0.8.4
	ocaml-sys-0.20.1
	once_cell-1.9.0
	oorandom-11.1.3
	opaque-debug-0.3.0
	openvino-0.3.1
	openvino-finder-0.3.1
	openvino-sys-0.3.1
	os_pipe-0.9.2
	owo-colors-2.1.0
	p256-0.9.0
	parity-wasm-0.41.0
	parking_lot-0.11.1
	parking_lot_core-0.8.3
	paste-1.0.5
	peeking_take_while-0.1.2
	pem-rfc7468-0.2.2
	pin-project-lite-0.2.6
	pkcs1-0.2.4
	pkcs8-0.7.6
	plotters-0.3.1
	plotters-backend-0.3.0
	plotters-svg-0.3.0
	poly1305-0.7.2
	polyval-0.5.3
	ppv-lite86-0.2.10
	pqcrypto-0.14.2
	pqcrypto-internals-0.2.1
	pqcrypto-kyber-0.7.3
	pqcrypto-traits-0.3.4
	pretty_env_logger-0.4.0
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.27
	proptest-1.0.0
	psm-0.1.13
	quick-error-1.2.3
	quick-error-2.0.1
	quote-1.0.9
	radium-0.5.3
	rand-0.7.3
	rand-0.8.3
	rand_chacha-0.2.2
	rand_chacha-0.3.0
	rand_core-0.5.1
	rand_core-0.6.3
	rand_hc-0.2.0
	rand_hc-0.3.0
	rand_xorshift-0.3.0
	rawbytes-0.1.1
	rayon-1.5.1
	rayon-core-1.9.1
	redox_syscall-0.2.8
	redox_users-0.4.0
	regalloc-0.0.34
	regex-1.5.4
	regex-automata-0.1.10
	regex-syntax-0.6.25
	region-2.2.0
	remove_dir_all-0.5.3
	rsa-0.5.0
	rustc-demangle-0.1.19
	rustc-hash-1.1.0
	rustc_version-0.4.0
	rustix-0.33.0
	rusty-fork-0.3.0
	ryu-1.0.5
	same-file-1.0.6
	scopeguard-1.1.0
	semver-1.0.3
	serde-1.0.126
	serde_cbor-0.11.1
	serde_derive-1.0.126
	serde_json-1.0.64
	sha2-0.9.8
	sharded-slab-0.1.1
	shellexpand-2.1.0
	shlex-1.1.0
	shuffling-allocator-1.1.2
	signature-1.3.1
	smallvec-1.6.1
	smawk-0.3.1
	souper-ir-2.1.0
	spin-0.5.2
	spki-0.4.1
	stable_deref_trait-1.2.0
	static_assertions-1.1.0
	strsim-0.8.0
	structopt-0.3.25
	structopt-derive-0.4.18
	subtle-2.4.0
	supports-color-1.3.0
	supports-hyperlinks-1.2.0
	supports-unicode-1.0.2
	syn-1.0.72
	synstructure-0.12.4
	system-interface-0.20.0
	tap-1.0.1
	target-lexicon-0.12.0
	tempfile-3.2.0
	term_size-0.3.2
	termcolor-1.1.2
	terminal_size-0.1.17
	textwrap-0.11.0
	textwrap-0.14.2
	thiserror-1.0.30
	thiserror-impl-1.0.30
	thread_local-1.1.3
	tinytemplate-1.2.1
	tokio-1.8.1
	tokio-macros-1.2.0
	toml-0.5.8
	tracing-0.1.26
	tracing-attributes-0.1.15
	tracing-core-0.1.21
	tracing-log-0.1.2
	tracing-subscriber-0.3.1
	typenum-1.13.0
	unicode-linebreak-0.1.2
	unicode-segmentation-1.7.1
	unicode-width-0.1.9
	unicode-xid-0.2.2
	universal-hash-0.4.0
	userfaultfd-0.4.2
	userfaultfd-sys-0.4.0
	uuid-0.8.2
	v8-0.33.0
	vec_map-0.8.2
	version_check-0.9.3
	wait-timeout-0.2.0
	walkdir-2.3.2
	wasi-0.9.0+wasi-snapshot-preview1
	wasi-0.10.2+wasi-snapshot-preview1
	wasm-bindgen-0.2.74
	wasm-bindgen-backend-0.2.74
	wasm-bindgen-macro-0.2.74
	wasm-bindgen-macro-support-0.2.74
	wasm-bindgen-shared-0.2.74
	wasm-encoder-0.6.0
	wasm-smith-0.7.1
	wasmi-0.7.0
	wasmi-validation-0.3.0
	wasmparser-0.82.0
	wasmprinter-0.2.32
	wast-35.0.2
	wast-39.0.0
	wat-1.0.41
	web-sys-0.3.51
	which-4.2.2
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	winx-0.31.0
	wyz-0.2.0
	xoodyak-0.7.2
	zeroize-1.4.2
	zeroize_derive-1.2.0
	zstd-0.10.0+zstd.1.5.2
	zstd-safe-4.1.4+zstd.1.5.2
	zstd-sys-1.6.3+zstd.1.5.2
"
inherit cargo
SRC_URI+=" $(cargo_crate_uris)"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="c-api +llvm_targets_WebAssembly"

DEPEND="llvm_targets_WebAssembly? ( dev-lang/rust[llvm_targets_WebAssembly] )"
RDEPEND="${DEPEND}"

src_prepare () {
	rmdir crates/wasi-common/WASI || true
	mv ${WORKDIR}/WASI-${WASI_HASH} crates/wasi-common/WASI

	rmdir crates/wasi-crypto/spec || true
	mv ${WORKDIR}/wasi-crypto-${WASI_CRYPTO_HASH} crates/wasi-crypto/spec

	rmdir crates/wasi-nn/spec || true
	mv ${WORKDIR}/wasi-nn-${WASI_NN_HASH} crates/wasi-nn/spec

	eapply_user
}

src_compile () {
	cargo_src_compile
	if use c-api; then
		cargo_src_compile --manifest-path crates/c-api/Cargo.toml
	fi
}

src_install () {
	cargo_src_install
	if use c-api; then
		dolib.a target/release/libwasmtime.a
		dolib.so target/release/libwasmtime.so
	fi
}
