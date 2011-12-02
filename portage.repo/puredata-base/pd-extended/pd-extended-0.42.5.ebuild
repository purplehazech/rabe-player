# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools flag-o-matic versionator

DESCRIPTION="Realtime multimedia environment plus a collection of plugins"
HOMEPAGE="http://www.puredata.org/"
SRC_URI="http://sourceforge.net/projects/pure-data/files/${PN}/${PV}/Pd-${PV}-extended.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

Linux="+hid +pdp +pidip +gem2pdp +iem16 +pdp_opengl +postlude"
externals="+oscx  +zexy +iem_matrix"
IUSE_PD_EXTERNALS="+adaptive +bassemu +boids +bsaylor +creb +cxc +cyclone
	+earplug +ekext +ext13 +flashserver +flatspace +flib +freeverb +ggee
	+hcs +iem_ambi +iem_bin_ambi +iemlib +iemgui +iem_adaptfilt +iemmatrix
	 +iemxmlrpc +iem_delay +iem_roomsim +iem_spec2 +iem_tab
	jasch_lib +loaders +mapping +markex +maxlib +mjlib +moocow
	+moonlib +motex +mrpeach +pan +pdcontainer +pddp +pdogg +pmpd
	+sigpack +smlib +tof +toxy +unauthorized +vanilla +vbap +windowing"
IUSE="alsa debug fftw jack portaudio ${IUSE_PD_EXTERNALS} ${Linux} ${externals}"

S="${WORKDIR}/Pd-0.42.5-extended/"

DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3
	alsa? ( >=media-libs/alsa-lib-0.9.0_rc2 )
	jack? ( >=media-sound/jack-audio-connection-kit-0.99.0-r1 )
	unauthorized? ( >=media-libs/speex-1.1.12
		media-sound/lame )
	pdogg? ( media-libs/libogg
		media-libs/libvorbis )
	media-sound/lame
	media-libs/flac
	media-libs/libsndfile
	fftw? ( sci-libs/fftw )
	hcs? ( dev-libs/libusb )
	portaudio? ( media-libs/portaudio )
	pdogg? ( media-libs/libogg )
	media-libs/ladspa-sdk
	sci-libs/fftw"
RDEPEND="${DEPEND}
	!puredata-base/pd"

src_prepare(){
	# configure pd
	cd "${S}/pd/src"
	eaclocal
	eautoconf
}

src_configure(){
	cd "${S}/pd/src"
	econf $(use_enable alsa) $(use_enable jack) \
		$(use_enable debug) $(use_enable fftw) \
		$(use_enable portaudio)
}

src_compile() {
	# build pd
	cd "${S}/pd/src"
	emake DESTDIR="${D}" prefix="/usr" \
		|| die "build of 'pd' failed"

	# build externals in $USE
	cd "${S}/externals"
	for external_useflag in ${IUSE_PD_EXTERNALS}; do
		local external=${external_useflag#[+-]}
		if use ${external}; then
			einfo ""
			einfo "Building external '${external}'"
			einfo ""
			local my_make_opts=""
			case ${external} in
			oscx|unauthorized|zexy)
				# stuff which fails with parallel make
				my_make_opts="${my_make_opts} -j1"
				;;
			esac
			emake OPT_CFLAGS="${CFLAGS} -fPIC -DPIC" DESTDIR="${D}" prefix="/usr" \
				${my_make_opts} ${external} || die "${external} failed"
		fi
	done
}

src_install() {
	#install pd
	cd "${S}/pd/src"
	emake DESTDIR="${D}" prefix="/usr" install || \
		die "install 'pd' failed"

	# and private headers for developers.
	insinto /usr/include
	doins m_pd.h m_imp.h g_canvas.h t_tk.h s_stuff.h g_all_guis.h

	# and externals
	cd "${S}/externals"
	for external_useflag in ${IUSE_PD_EXTERNALS}; do
		local external=${external_useflag#[+-]}
		if use ${external}; then
			einfo ""
			einfo "Installing external '${external}'"
			einfo ""
			emake DESTDIR="${D}" prefix="/usr" ${external}_install || \
				die "install '${external}' failed"
		fi
	done

	doicon packages/linux_make/pd-48x48.png
	make_desktop_entry "pdextended -rt" "PureData" "pd-48x48.png" "AudioVideo;Audio"
}
