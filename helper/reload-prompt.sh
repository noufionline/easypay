#!/bin/bash

sed -i 's#OSH_THEME="font"#OSH_THEME="90210"#g' ~/.bashrc

eval "$(cat ~/.bashrc | tail -n +10)"