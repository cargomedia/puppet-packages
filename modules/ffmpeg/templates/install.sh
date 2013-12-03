#!/bin/sh -e

curl -sL http://ffmpeg.org/releases/ffmpeg-<%= @version %>.tar.gz >ffmpeg-<%= @version %>.tar.gz
tar -xvf ffmpeg-<%= @version %>.tar.gz
cd ffmpeg-<%= @version %>
./configure --enable-libspeex --enable-libx264 --enable-libfaac --enable-gpl --enable-nonfree --enable-shared --enable-version3 --enable-runtime-cpudetect
make
make install
ldconfig
