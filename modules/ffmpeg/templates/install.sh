#!/bin/sh
FFMPEG_VERSION='<%= @version %>'
if ! ((test -x /usr/local/bin/ffmpeg) && (ffmpeg -version 2>/dev/null |grep -q "^ffmpeg version $FFMPEG_VERSION$")); then
	curl -sL http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz > yasm-1.2.0.tar.gz
	tar -xvf yasm-1.2.0.tar.gz
	cd yasm-1.2.0
	./configure
	make
	make install
	cd ..
	git clone git://git.videolan.org/x264
	cd x264
	./configure --enable-shared
	make
	make install
	cd ..
	curl -sL http://ffmpeg.org/releases/ffmpeg-$FFMPEG_VERSION.tar.gz >ffmpeg-$FFMPEG_VERSION.tar.gz
	tar -xvf ffmpeg-$FFMPEG_VERSION.tar.gz
	cd ffmpeg-$FFMPEG_VERSION
	./configure --enable-libspeex --enable-libx264 --enable-libfaac --enable-gpl --enable-nonfree --enable-shared --enable-version3 --enable-runtime-cpudetect
	make 2>/dev/null # Without dumping STDERR the calling ssh process will strangely hang indefinitely
	make install
	cd ..
	ldconfig
fi
