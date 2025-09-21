cd "`dirname "$0"`"
cd "../"

emcmake cmake -S . -B build
cd build
emmake make
