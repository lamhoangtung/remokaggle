# Better bash env
cd ~
wget https://raw.githubusercontent.com/lamhoangtung/kaggle-kernel-setup/master/.bashrc
mv .bashrc.1 .bashrc
source .bashrc

# htop, tmux, nano ...
apt-get install nano htop tmux cmake libncurses5-dev libncursesw5-dev git tree zip

# nvtop
git clone https://github.com/Syllo/nvtop.git
mkdir -p nvtop/build && cd nvtop/build
cmake ..

# If it errors with "Could NOT find NVML (missing: NVML_INCLUDE_DIRS)"
# try the following command instead, otherwise skip to the build with make.
cmake .. -DNVML_RETRIEVE_HEADER_ONLINE=True

make
make install # You may need sufficient permission for that (root)

# drive-cli
pip install drive-cli
drive --remote login #--noauth_local_webserver

# Upgrade tensorboardX to avoid some small bugs
pip install tensorboardX --upgrade