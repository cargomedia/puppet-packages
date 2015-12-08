node default {

  class { 'gstreamer::plugins::base': }
  class { 'gstreamer::plugins::good': }
  class { 'gstreamer::plugins::libav': }
  class { 'gstreamer::plugins::bad': }
  class { 'gstreamer::plugins::ugly': }

}
