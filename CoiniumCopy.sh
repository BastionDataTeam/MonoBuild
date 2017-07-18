# /bin/bash

wget -np -nH -r http://10.0.0.211/build/CoiniumServ/bin/Release/
mono build/CoiniumServ/bin/Release/CoiniumServ.exe
