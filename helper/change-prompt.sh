#!/bin/bash

bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

# Recommended and currently using

# https://starship.rs/


curl -sS https://starship.rs/install.sh | sh

#Add the following to the end of ~/.bashrc:

eval "$(starship init bash)"

