On first use make sure you run...

```
git submodule update --init --recursive
```



Then to sync to latest branch...

```
git submodule update --recursive --remote
```


Finally
```
cmake -B build -DCMAKE_TOOLCHAIN_FILE="D:/git/vcpkg/scripts/buildsystems/vcpkg.cmake"
cmake --build build -j
cmake --build build -j --config Release
```

Install (broken) Release
```
cmake --install build
```

Merge Notes
```
copy v175-merge-00/ggml/src/ggml-flat.cpp live/ggml/src/
copy v175-merge-00/ggml/src/ggml-flat.h   live/ggml/src/
copy v175-merge-00/src/whisper-flat.cpp   live/src/
copy v175-merge-00/src/whisper-flat.h     live/src/

copy v175-merge/examples/bench2 live/examples
copy v175-merge/examples/cli2   live/examples

winmergeu live/CMakeLists.txt v175-merge/CMakeLists.txt
winmergeu live/examples/CMakeLists.txt  v175-merge/examples/CMakeLists.txt
winmergeu live/ggml/CMakeLists.txt  v175-merge/ggml/CMakeLists.txt
winmergeu live/ggml/src/CMakeLists.txt  v175-merge/ggml/src/CMakeLists.txt
winmergeu live/ggml/src/ggml-backend-reg.cpp  v175-merge/ggml/src/ggml-backend-reg.cpp
winmergeu live/include/whisper.h  v175-merge/include/whisper.h
winmergeu live/src/CMakeLists.txt  v175-merge/src/CMakeLists.txt
winmergeu live/src/whisper.cpp  v175-merge/src/whisper.cpp
```

Submodule Add
```
git submodule add -b v175-merge-01 https://github.com/WhisperBooks/whisper.cpp whisper.cpp
```
