#!/bin/bash -e

rsync -a --delete '<%= @puppetfile_hiera_data_dir %>' '<%= @hiera_data_dir %>/'
