## WhatIsMyIP
 [![basher install](https://www.basher.it/assets/logo/basher_install.svg)](https://www.basher.it/package/)\
This is a whatismyip bash script for linux.
It depends on a bunch of services, picks one randomly and executes curl to determine your WAN IP address. It returns only that, nothing else.

## Installing

```bash
git clone https://github.com/BigFunnyGiant/bash-whatismyip # clone the repository
cd bash-whatismyip
cp whatismyip.sh /usr/local/bin
```
or copy it to somewhere you like, maybe in the PATH so you can execute it from anywhere\
\
Or\
\
use Basher
```bash
basher install BigFunnyGiant/bash-whatismyip
```

## Usage
./whatismyip.sh 4 for IPV4\
./whatismyip.sh 6 for IPV6\
or\
./whatismyip.sh\ 
it will ask you which\

## Dependencies
- bash
- sed
- curl
