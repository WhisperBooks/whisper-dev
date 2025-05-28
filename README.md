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
