# Better bash env
cd ~
wget https://raw.githubusercontent.com/lamhoangtung/kaggle-kernel-setup/master/.bashrc
mv .bashrc.1 .bashrc
source .bashrc

# htop, tmux, nano ...
apt-get -y install nano htop tmux cmake libncurses5-dev libncursesw5-dev git tree zip expect

# drive-cli
cd ~
wget https://github.com/gdrive-org/gdrive/releases/download/2.1.0/gdrive-linux-x64
mv gdrive-linux-x64 gdrive
chmod +x gdrive
install gdrive /usr/local/bin/gdrive
gdrive about

# Upgrade tensorboardX to avoid some small bugs
pip install tensorboardX --upgrade
pip install ipdb trains
pip install --upgrade imgaug
pip install scikit-learn==0.20.3
pip install tensorflow-gpu==1.14.0

# nvtop
conda deactivate
git clone https://github.com/Syllo/nvtop.git
mkdir -p nvtop/build && cd nvtop/build
cmake ..
# If it errors with "Could NOT find NVML (missing: NVML_INCLUDE_DIRS)"
# try the following command instead, otherwise skip to the build with make.
cmake .. -DNVML_RETRIEVE_HEADER_ONLINE=True

make
make install # You may need sufficient permission for that (root)

# rclone for data backup
curl https://rclone.org/install.sh | bash
rclone config

conda install -c eumetsat expect
trains-init

# Setting up swap
# dd if=/dev/zero of=/swapfile-additional bs=1M count=32768
# mkswap /swapfile-additional
# cdmod 600 /swapfile-additional
# echo "/swapfile-additional    swap swap    0   0" >> /etc/fstab
# mount -a
# swapon -a
# free -m
