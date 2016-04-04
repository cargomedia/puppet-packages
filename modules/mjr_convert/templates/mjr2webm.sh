#!/bin/bash
set -e
function error {
  >&2 echo $1
  exit 1
}

# set defaults
ffmpegParams="-map 0:v -map 1:a -codec copy"

# parse optional arguments
while test $# -gt 0
do
  case $1 in
    --help)
      echo "Usage: mjr2webm [--ffmpeg-params <ffmpeg-params>] <video-mjr-source> <audio-mjr-source> <output-file>"
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
audioMjr=$2
outputFile=$3

if [ -z $videoMjr ] || [ ! -f $videoMjr ] || [[ "$videoMjr" != *.mjr ]]; then
  error "Must specify existing <video-mjr-source>"
fi

if [ -z $audioMjr ] || [ ! -f $audioMjr ] || [[ "$audioMjr" != *.mjr ]]; then
    error "Must specify existing <audio-mjr-source>"
fi

if [ -z $outputFile ]; then
  error "Must specify <output-file>"
fi

TFILE="$$"
videoSource=$TFILE.webm
audioSource=$TFILE.opus

janus-pp-rec $videoMjr $videoSource
janus-pp-rec $audioMjr $audioSource

command="ffmpeg -i $videoSource -i $audioSource $ffmpegParams $outputFile"
echo $command
$command
test -f "${outputFile}" || error "No output file generated"

rm $videoSource
rm $audioSource
