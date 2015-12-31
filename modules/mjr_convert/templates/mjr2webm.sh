#!/bin/bash
set -e
#
# Copyright (c) 2015 Me
# Rev: PA1
# Convert local Janus .mjr files (audio and video) to an .webm file
# containing video and 2ch audio (vp8 + opus)
#
# dependencies:
#    janus-pp-rec (Janus postprocessing) must have been compiled and installed
#    ffmpeg (2015->) must have been installed.
#    (static versions for download exist on the internet)
#
# input is:
# mjr2webm -v myvideo.mjr -a myaudio.mjr out.webm
myhelp () {
    echo $0
    echo 'Usage: mjr2webm -v [videofile] -a [audiofile] --ffmpegVideoParams [ffmpegVideoParams] --ffmpegAudioParams [ffmpegAudioParams] [outputfile]'
    echo '   "[videofile]" must be a .mjr video file output from Janus'
    echo '   "[audiofile]" must be a .mjr audio file output from Janus'
    echo '   "[ffmpegVideoParams]" overwrite video ffmpeg params'
    echo '   "[ffmpegAudioParams]" overwrite audio ffmpeg params'
    echo '   "[outputfile]", if not specified, is "default.webm"; if specified, it must end with filetype ".webm"'
}


if test $# -eq 0; then
   myhelp
   exit 0
fi

if ! which ffmpeg > /dev/null; then
   if ! which ./ffmpeg > /dev/null; then
     echo "Aborting: No 'ffmpeg' found" 1>&2
     exit 1
   else
      ffmpeg=./ffmpeg
   fi
else
   ffmpeg=ffmpeg
fi

if ! which janus-pp-rec > /dev/null; then
     echo "Aborting: No 'janus-pp-rec' found" 1>&2
     exit 1
fi


ffmpegVideoParams = "-c:v libvpx -b:v 500k -r 25"
ffmpegAudioParams = "-c:a libopus -b:a 64k"

while test $# -gt 0
do
  case $1 in

  # Normal option processing
    -h | --help)
      # usage and help
      myhelp
      exit 0
      break
      ;;
    -v | --video)
      shift
      video=$1
      ;;
    -a | --audio)
      shift
      audio=$1
      ;;
    --ffmpeg-audio-params)
      shift
      ffmpegAudioParams=$1
      ;;
    --ffmpeg-video-params)
      shift
      ffmpegVideoParams=$1
      ;;
  # ...
  # Done with options
    *)
      break
      ;;
  esac

  shift
done

if ! [ -z $video ]; then
  if ! [ -f $video ]; then
     echo "Videofile $video does not exist"
     exit 1
  else
     if ! [[ "$video" == *.mjr ]]; then
        echo "Video file must end with .mjr"
        exit 1
     fi
  fi
fi
if ! [ -f $audio ]; then
   echo "Audio $audio does not exist"
   exit 1
else
   if ! [[ "$audio" == *.mjr ]]; then
      echo "Audio file must end with .mjr"
      exit 1
   fi
fi

if [ -z "$1" ]; then
    echo "Using default.webm as output file"
    out=default.webm
else
    out=$1
    if ! [[ "$out" == *.webm ]]; then
       echo "Output file must end with .webm"
       exit 1
    fi
fi

TFILE="$$"
opus=$TFILE.opus
webm=$TFILE.webm
ffmpegParams=""

# convert video to webm
if ! [ -z $video ]; then
  janus-pp-rec $video $webm
  ffmpegParams="$ffmpegParams -i $webm $ffmpegVideoParams"
fi

# convert audio to opus
if ! [ -z $audio ]; then
  janus-pp-rec $audio $opus
  ffmpegParams="$ffmpegParams -i $opus $ffmpegAudioParams"
fi
echo $ffmpeg $ffmpegParams $out
$ffmpeg $ffmpegParams $out

if [ -e $webm ]; then
  rm $webm
fi
if [ -e $opus ]; then
  rm $opus
fi

echo "done!"
