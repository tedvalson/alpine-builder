#!/bin/sh
set -e
set -x

uname -a
#apk update
#apk add -q musl-dev gcc g++ clang18 llvm18 py3-pip cmake make curl autoconf bison ninja cargo meson git
#apk add -q python3-dev openssl-dev clang18-libclang
#apk add -q --no-cache libc6-compat pkgconfig dav1d libdav1d dav1d-dev npm gcc
sudo apt-get update
sudo apt install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update
sudo apt-get install -y nodejs

npm i -g "@napi-rs/cli@${NAPI_CLI_VERSION}"
rustup show
rustup toolchain install nightly
rustup target add --toolchain nightly armv7-unknown-linux-musleabihf
rustup target add armv7-unknown-linux-musleabihf
rustup default nightly
rustup component add rust-src --toolchain nightly-2024-08-01-x86_64-unknown-linux-gnu
#export PATH=~/.cargo/bin:$PATH
#export RUSTUP_OVERRIDE_BUILD_TRIPLE=armv7-unknown-linux-musleabihf

mkdir /host/build
cd /host/build
git clone --depth 2 https://github.com/vercel/next.js.git next

node -v

#npm i --verbose -g "turbo@1.13.3-canary.2" "@napi-rs/cli@2.14.7"
cd next/packages/next-swc
#export RUSTFLAGS="-C linker=armv7-alpine-linux-musleabihf-ld"
npm run build-native-release -- --cargo-flags="-Zbuild-std" --target armv7-unknown-linux-musleabihf
llvm-strip -x native/next-swc.*.node

# "build-native-release": "napi build --platform -p next-swc-napi --cargo-cwd ../../ --cargo-name next_swc_napi --release --features plugin,image-extended,tracing/release_max_level_info --js false native",

ls native/
