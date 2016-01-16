#!/bin/bash
set -e

function error {
  >&2 echo $1
  exit 1
}

# parse optional arguments
while test $# -gt 0
do
  case $1 in
    --help)
      echo "Usage: mjr2webm [--ffmpeg-params <ffmpeg-params>] <video-mjr-source> <output-file>"
      exit 1
      ;;
    --ffmpeg-params)
      shift
      ffmpegParams=$1
      ;;
    *)
      break
      ;;
  esac
  shift
done

videoMjr=$1
outputFile=$2

if [ -z $videoMjr ] || [ ! -f $videoMjr ] || [[ "$videoMjr" != *.mjr ]]; then
  error "Must specify existing <video-mjr-source>"
fi

if [ -z $width ] || [ -z $height ]; then
    error "Must specify <width> and <height>"
fi

if [ -z $outputFile ]; then
  error "Must specify <output-file>"
fi

if [ -z $ffmpegParams ]; then
  ffmpegParams="-map 0:0 -codec png -frames 1 -y"
fi

videoSource="$$.webm"
janus-pp-rec $videoMjr $videoSource
command="ffmpeg -i ${videoSource} $ffmpegParams ${outputFile}"
echo $command
$command
rm $videoSource
