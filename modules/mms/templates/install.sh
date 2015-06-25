#!/bin/bash -e

curl -Ls https://cloud.mongodb.com/download/agent/monitoring/mongodb-<%= @agent_name %>-agent_<%= @version %>-1_amd64.deb > <%= @agent_name %>.deb
sudo dpkg -i --force-confold <%= @agent_name %>.deb
