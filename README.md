```sh
docker build . -t balatro-test
docker run --rm -it -v ./Mods:/balatro/mods -v ~/path/to/Balatro.exe:/balatro/game balatro-test
````
