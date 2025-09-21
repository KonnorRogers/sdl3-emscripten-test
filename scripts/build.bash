cd "`dirname "$0"`"
cd "../"

mkdir -p build

source ./vendor/emscripten/emsdk_env.sh

emcmake cmake -S . -B build/html
cd build/html
emmake make

cd ../../
cmake -S . -B build/native
cmake --build build/native

