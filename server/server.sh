#!/bin/bash

PORT=5000

echo 'preparing port' $PORT '...'
fuser -k 5000/tcp

cd build/web/

echo 'Server starting on port' $PORT '...'
python3 -m http.server $PORT