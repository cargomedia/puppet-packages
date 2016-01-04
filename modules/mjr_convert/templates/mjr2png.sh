#!/bin/bash
set -e
#
# Copyright (c) 2015 Me
# Rev: PA1
# Convert local Janus .mjr file (video) to a .png file
# containing video and 2ch audio (vp8 + opus)
#
# dependencies:
#    janus-pp-rec (Janus postprocessing) must have been compiled and installed
#    ffmpeg (2015->) must have been installed.
#    (static versions for download exist on the internet)
#
# input is:
# mjr2png -v myvideo.mjr out.png
myhelp () {
    echo $0
    echo 'Usage: mjr2png --video videofile --height height --width width [outputfile]'
    echo '   "videofile" must be a .mjr video file output from Janus'
    echo '   "height" height of the png'
    echo '   "width" width of the png'
    echo '   "[outputfile]", if not specified, is "default.png"; if specified, it must end with filetype ".png"'
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

while test $# -gt 0
do
  case $1 in

  # Normal option processing
    --help)
      # usage and help
      myhelp
      exit 0
      break
      ;;
    --video)
      shift
      video=$1
      ;;
    --height)
      shift
      height=$1
      ;;
    --width)
      shift
      width=$1
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

if [ -z "$1" ]; then
    echo "Using default.png as output file"
    out=default.png
else
    out=$1
    if ! [[ "$out" == *.png ]]; then
       echo "Output file must end with .png"
       exit 1
    fi
fi

webm="$$.webm"
janus-pp-rec $video $webm
$ffmpeg -threads 1 -i "${webm}" -an -vcodec png -vframes 1 -f image2 -s "${width}x${height}" -y -loglevel warning "${out}"
rm $webm
