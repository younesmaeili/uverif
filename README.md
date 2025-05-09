# Required Packages
1. `sudo apt update`
2. `sudo apt install tcl8.6-dev clang gcc g++ build-essential libedit-dev libreadline-dev`
3. Also `pandas` and `numpy`.

# Setting Environment for TabbyCAD Suit and JasperGold
1. `sudo nano ~/.bashrc`
   
export PATH="/home/$USER/tabby/bin:$PATH"

export YOSYSHQ_LICENSE="/home/$USER/Documents/tabby.lic"

export LM_LICENSE_FILE=your license address

export PATH="/home/$USER/jasper_2024.12/bin:$PATH"

2. `source ~/.bashrc`

# Generating uspec
1. `make init` within `uverif` directory.
2. `make intra_hbi`
3. `cd /vscale`
4. `chmod +x RUN_JG.sh`
5. `python3 revised_script/intra_hbi.py`
