#!/bin/sh -e

curl -Ls https://mms.mongodb.com/download/agent/monitoring/<%= @agent_name %>_<%= @version %>-1_amd64.deb > <%= @agent_name %>.deb
sudo dpkg -i <%= @agent_name %>.deb
