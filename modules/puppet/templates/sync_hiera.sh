#!/bin/bash -e

rsync -a --delete '<%= @hiera_data_repo %>' '<%= @hiera_data_dir %>/'
