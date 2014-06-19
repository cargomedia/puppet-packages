#!/bin/bash -e

curl -Ls https://mms.mongodb.com/download/agent/monitoring/mongodb-<%= @agent_name %>-agent_<%= @version %>-1_amd64.deb > <%= @agent_name %>.deb
sudo dpkg -i <%= @agent_name %>.deb
