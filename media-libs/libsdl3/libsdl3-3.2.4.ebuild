# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Simple Direct Media Layer"
HOMEPAGE="https://www.libsdl.org/"
SRC_URI="https://github.com/libsdl-org/SDL/releases/download/release-${PV}/SDL3-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/SDL3-${PV}"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc ~ppc64 ~x86"

IUSE="X alsa asm +audio cpu_flags_x86_avx cpu_flags_x86_avx2 cpu_flags_x86_avx512f cpu_flags_x86_mmx cpu_flags_x86_sse cpu_flags_x86_sse2 cpu_flags_x86_sse3 cpu_flags_x86_sse4_1 cpu_flags_x86_sse4_2 camera custom-cflags dbus debug dialog doc dummy dxvk gles gpu +haptic ibus jack +joystick kms libusb metal opengl oss pipewire +power +pthread pulseaudio sensor +shared-libs sndio static-libs system-iconv test udev +video vulkan wayland xcursor xdbe xfixes xinput xrandr xscreensaver xshape"
RESTRICT="!test? ( test )"

REQUIRED_USE="
	alsa?         ( audio    )
	dxvk?         ( gpu      )
	haptic?       ( joystick )
	ibus?         ( dbus     )
	jack?         ( audio    )
	gles?         ( video    )
	gpu?          ( video    )
	metal?        ( video    )
	opengl?       ( video    )
	oss?          ( audio    )
	pipewire?     ( audio    )
	pulseaudio?   ( audio    )
	sndio?        ( audio    )
	vulkan?       ( video    )
	wayland?      ( gles     )
	xcursor?      ( X        )
	xdbe?         ( X        )
	xfixes?       ( X        )
	xinput?       ( X        )
	xrandr?       ( X        )
	xscreensaver? ( X        )
	xshape?       ( X        )
"

COMMON_DEPEND="
	X? (
		>=x11-libs/libX11-1.6.2
		>=x11-libs/libXext-1.3.2
		>=x11-libs/libXi-1.7.2
	)
	alsa? ( >=media-libs/alsa-lib-1.0.27.2 )
	dbus? ( >=sys-apps/dbus-1.6.18-r1 )
	ibus? ( app-i18n/ibus )
	jack? ( virtual/jack )
	kms? (
		>=x11-libs/libdrm-2.4.82
		>=media-libs/mesa-9.0.0[gbm(+)]
	)
	opengl? (
		>=virtual/opengl-7.0-r1
		>=virtual/glu-9.0-r1
	)
	pipewire? ( media-video/pipewire:= )
	pulseaudio? ( media-libs/libpulse )
	sndio? ( media-sound/sndio:= )
	udev? ( >=virtual/libudev-208:= )
	virtual/libiconv
	wayland? (
		>=dev-libs/wayland-1.20
		gui-libs/libdecor
		>=media-libs/mesa-9.1.6[wayland]
		>=x11-libs/libxkbcommon-0.2.0
	)
	xcursor? ( >=x11-libs/libXcursor-1.1.14 )
	xfixes? ( >=x11-libs/libXfixes-6.0.0 )
	xrandr? ( >=x11-libs/libXrandr-1.4.2 )
	xscreensaver? ( >=x11-libs/libXScrnSaver-1.2.2-r1 )
"

RDEPEND="
	${COMMON_DEPEND}
	opengl? ( media-libs/mesa[opengl(+)] )
	vulkan? (
		media-libs/mesa[vulkan(+)]
		vulkan? ( media-libs/vulkan-loader )
	)
"

DEPEND="
	${COMMON_DEPEND}
	gles? ( media-libs/libglvnd )
	ibus? ( dev-libs/glib:2 )
	test? ( x11-libs/libX11 )
	vulkan? ( dev-util/vulkan-headers )
	X? ( x11-base/xorg-proto )
"

BDEPEND="
	virtual/pkgconfig
	doc? (
		app-text/doxygen
		media-gfx/graphviz
	)
	wayland? ( >=dev-util/wayland-scanner-1.20 )
"

src_configure() {
	use custom-cflags || strip-flags

	local mycmakeargs=(
		-DSDL_ALSA=$(usex alsa)
		-DSDL_ALSA_SHARED=$(usex alsa)
		-DSDL_ASAN=$(usex debug)
		-DSDL_ASSEMBLY=$(usex asm)
		-DSDL_ASSERTIONS=$(usex debug enabled disabled)
		-DSDL_AUDIO=$(usex audio)
		-DSDL_AVX=$(usex cpu_flags_x86_avx)
		-DSDL_AVX2=$(usex cpu_flags_x86_avx2)
		-DSDL_AVX512F=$(usex cpu_flags_x86_avx512f)
		-DSDL_CAMERA=$(usex camera)
		-DSDL_CCACHE=OFF
		-DSDL_DBUS=$(usex dbus)
		-DSDL_DIALOG=$(usex dialog)
		-DSDL_DISABLE_INSTALL=OFF
		-DSDL_DISABLE_INSTALL_CPACK=OFF
		-DSDL_DISABLE_INSTALL_DOCS=$(usex doc OFF ON)
		-DSDL_DISKAUDIO=$(usex audio)
		-DSDL_DUMMYAUDIO=$(use audio && use dummy && echo ON || echo OFF)
		-DSDL_DUMMYCAMERA=$(use camera && use dumyy && echo ON || echo OFF)
		-DSDL_DUMMYVIDEO=$(use video && use dummy && echo ON || echo OFF)
		-DSDL_EXAMPLES=$(usex doc)
		-DSDL_EXAMPLES_LINK_SHARED=$(usex shared-libs)
		-DSDL_GCC_ATOMICS=ON
		-DSDL_GPU=$(usex gpu)
		-DSDL_GPU_DXVK=$(usex dxvk)
		-DSDL_HAPTIC=$(usex haptic)
		-DSDL_HIDAPI=ON
		-DSDL_HIDAPI_JOYSTICK=$(usex joystick)
		-DSDL_HIDAPI_LIBUSB=$(usex libusb)
		-DSDL_HIDAPI_LIBUSB_SHARED=$(usex libusb)
		-DSDL_IBUS=$(usex ibus)
		-DSDL_JACK=$(usex jack)
		-DSDL_JACK_SHARED=$(usex jack)
		-DSDL_JOYSTICK=$(usex joystick)
		-DSDL_KMSDRM=$(usex kms)
		-DSDL_KMSDRM_SHARED=$(usex kms)
		-DSDL_LIBC=ON
		-DSDL_LIBICONV=$(usex system-iconv)
		-DSDL_SYSTEM_ICONV=$(usex system-iconv)
		-DSDL_LIBUDEV=$(usex udev)
		-DSDL_MMX=$(usex cpu_flags_x86_mmx)
		-DSDL_OFFSCREEN=$(usex video)
		-DSDL_OPENGL=$(usex opengl)
		-DSDL_OPENGLES=$(usex gles)
		-DSDL_OSS=$(usex oss)
		-DSDL_PIPEWIRE=$(usex pipewire)
		-DSDL_PIPEWIRE_SHARED=$(usex pipewire)
		-DSDL_POWER=$(usex power)
		-DSDL_PTHREADS=$(usex pthread)
		-DSDL_PTHREADS_SEM=$(usex pthread)
		-DSDL_PULSEAUDIO=$(usex pulseaudio)
		-DSDL_PULSEAUDIO_SHARED=$(usex pulseaudio)
		-DSDL_RENDER=$(usex video)
		-DSDL_RENDER_GPU=$(usex gpu)
		-DSDL_RENDER_METAL=$(usex metal)
		-DSDL_RENDER_VULKAN=$(usex vulkan)
		-DSDL_RPATH=ON
		-DSDL_SENSOR=$(usex sensor)
		-DSDL_SHARED=$(usex shared-libs)
		-DSDL_SNDIO=$(usex sndio)
		-DSDL_SNDIO_SHARED=$(usex sndio)
		-DSDL_SSE=$(usex cpu_flags_x86_sse)
		-DSDL_SSE2=$(usex cpu_flags_x86_sse2)
		-DSDL_SSE3=$(usex cpu_flags_x86_sse3)
		-DSDL_SSE4_1=$(usex cpu_flags_x86_sse4_1)
		-DSDL_SSE4_2=$(usex cpu_flags_x86_sse4_2)
		-DSDL_STATIC=$(usex static-libs)
		-DSDL_TESTS=$(usex test)
		-DSDL_TESTS_LINK_SHARED=$(usex shared-libs)
		-DSDL_TEST_LIBRARY=$(usex test)
		-DSDL_VIDEO=$(usex video)
		-DSDL_VIRTUAL_JOYSTICK=$(usex joystick)
		-DSDL_VULKAN=$(usex vulkan)
		-DSDL_WAYLAND=$(usex wayland)
		-DSDL_WAYLAND_LIBDECOR=$(usex wayland)
		-DSDL_WAYLAND_LIBDECOR_SHARED=$(usex wayland)
		-DSDL_WAYLAND_SHARED=$(usex wayland)
		-DSDL_WERROR=$(usex debug)
		-DSDL_X11=$(usex X)
		-DSDL_X11_SHARED=$(usex X)
		-DSDL_X11_XCURSOR=$(usex xcursor)
		-DSDL_X11_XDBE=$(usex xdbe)
		-DSDL_X11_XFIXES=$(usex xfixes)
		-DSDL_X11_XINPUT=$(usex xinput)
		-DSDL_X11_XRANDR=$(usex xrandr)
		-DSDL_X11_XSCRNSAVER=$(usex xscreensaver)
		-DSDL_X11_XSHAPE=$(usex xshape)
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile

	if use doc; then
		cd docs || die
		doxygen || die
	fi
}

src_test() {
	unset SDL_GAMECONTROLLERCONFIG SDL_GAMECONTROLLER_USE_BUTTON_LABELS
	cmake_src_test
}

src_install() {
	cmake_src_install

	if use doc; then
		dodoc -r examples/
	fi
}
