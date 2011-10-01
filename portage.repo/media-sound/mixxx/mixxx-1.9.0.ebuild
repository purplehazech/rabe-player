# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit qt4 toolchain-funcs

MY_PD="${P/_/-}"
MY_PF="${P/_/~}"

DESCRIPTION="Digital DJ tool using QT 4.x"
HOMEPAGE="http://mixxx.sourceforge.net"
SRC_URI="http://downloads.mixxx.org/${MY_PD}/${MY_PF}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

RDEPEND=">=x11-libs/qt-core-4.3:4
		x11-libs/qt-gui:4
		x11-libs/qt-svg:4
		x11-libs/qt-opengl:4
		x11-libs/qt-qt3support:4
		media-libs/libmad
		media-libs/libvorbis
		media-libs/libsndfile
		media-libs/libid3tag
		>=media-libs/portaudio-19_pre
		virtual/glu
		media-libs/taglib
		media-libs/portmidi
		x11-libs/qt-webkit
		alsa? ( media-libs/alsa-lib )
		jack? ( media-sound/jack-audio-connection-kit )
		djconsole? ( media-libs/libdjconsole )
		ffmpeg? ( media-video/ffmpeg
				  media-sound/gsm
				  media-libs/libdc1394
				  sys-libs/libraw1394
				  media-libs/libdca
				  media-libs/a52dec )
		ladspa? ( media-libs/ladspa-sdk )
		shout? ( media-libs/libshout )"

DEPEND="${RDEPEND}
	sys-apps/sed
	dev-util/scons
	dev-lang/perl
	dev-util/pkgconfig"

IUSE="alsa jack ladspa djconsole hifieq shout tonal +vinylcontrol ffmpeg"

S="${WORKDIR}/${MY_PF}~release-1.9.x~bzr2720"

pkg_setup() {
	if use jack; then
		if ! built_with_use media-libs/portaudio jack; then
			eerror "To have jack support, you need to compile portaudio"
			eerror "with USE=\"jack\"!"
			die
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# use our own CXXFLAGS/CFLAGS
	esed_check -i \
		-e "0,/\(^env.Append.*\)/s//\1\nenv.Append(CCFLAGS = Split(\"\"\" \
		${CFLAGS} \"\"\"))/" \
		-e "0,/\(^env.Append.*\)/s//\1\nenv.Append(CXXFLAGS = ' ${CXXFLAGS} ')/" \
		"${S}/src/SConscript"
}

src_compile() {
	myconf=""
	! use ladspa; myconf="ladspa=$?"
	# disable ffmpeg for now, it doesn't compile as of 20090429
	#! use ffmpeg; myconf="${myconf} ffmpeg=$?"
	myconf="${myconf} ffmpeg=0"
	! use djconsole; myconf="${myconf} djconsole=$?"
	! use hifieq; myconf="${myconf} hifieq=$?"
	! use shout; myconf="${myconf} shoutcast=$?"
	! use tonal; myconf="${myconf} tonal=$?"
	myconf="${myconf} prefix=/usr"
	myconf="${myconf} qtdir=/usr/share/qt4"

	mkdir -p "${D}/usr"
	einfo "selected options: ${myconf}"
	tc-export CC CXX
	scons ${myconf} || die "scons failed"
}

src_install() {
	mkdir -p "${D}/usr"
	scons ${myconf} install_root="${D}/usr" install || die
	dodoc README Mixxx-Manual.pdf
}
