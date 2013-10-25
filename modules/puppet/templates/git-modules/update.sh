#!/bin/bash
set -e
cd <%= @path %>
git fetch origin/<%= @version %>
git checkout origin/<%= @version %>

