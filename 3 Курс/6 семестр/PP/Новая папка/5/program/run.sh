#!/usr/bin/expect -f
set timeout -1
spawn pvm
expect *
send  -- "spawn -> master $env(HOME)/pvm3/bin/$env(PVM_ARCH)/matrix.txt $env(HOME)/pvm3/bin/$env(PVM_ARCH)/result.txt \r"
interact q return
send "\r"
