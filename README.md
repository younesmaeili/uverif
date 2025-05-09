# Required Packages
1. `sudo apt update`
2. `sudo apt install tcl8.6-dev clang gcc g++ build-essential libedit-dev libreadline-dev`

# Setting Environment for TabbyCAD Suit
1. `sudo nano ~/.bashrc`
   
export PATH="/home/$USER/tabby/bin:$PATH"

export YOSYSHQ_LICENSE="/home/$USER/Documents/tabby.lic"

2. `source ~/.bashrc`

# Generating uspec
1. `make init` within `uverif` directory.
2. `make intra_hbi`
