#!/bin/sh -e

curl -Ls https://mms.mongodb.com/download/agent/monitoring/mongodb-mms-monitoring-agent_<%= @version %>-1_amd64.deb > mongodb-mms-monitoring-agent.deb
sudo dpkg -i mongodb-mms-monitoring-agent.deb
