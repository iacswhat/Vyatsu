run on ubuntu20.04 wsl


set env
export PVM_ROOT=/home/user/pvm_root/pvm3
export PVM_ARCH=LINUX64


compile pvm (запускать от root)
cd /home/user/pvm_root/pvm3
make
make g


compile program:
make


pre-run:
remove /tmp/pvm* files
exec "pvm" for start deamon


run (expect is required):
./run.sh