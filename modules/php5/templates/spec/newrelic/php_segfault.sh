#!/bin/bash

(php -r 'sleep(10);' &) && sleep 1 && kill -11 $(pgrep php)
