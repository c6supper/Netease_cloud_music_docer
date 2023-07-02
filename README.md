# netease_music_env docker builder
       
* Build docker
    1.docker build --progress=plain -t c6supper/netease_music_env -f docker/Dockerfile ./
    
* Build release docker
    1. change the version
    2. ./build-env/build.sh c6supper netease_music_env release
