@echo off
rem whisper-dev: builds the whisper.cpp libraries and collects them in dlls\
rem
rem Works from any prompt: when the x64 Visual Studio build environment is not
rem active it is set up here (vswhere + vcvars64). Uses the Ninja Multi-Config
rem generator, as whisper.cpp's own Windows release builds do: the Visual
rem Studio generator compiles CUDA through NVIDIA's MSBuild integration, which
rem may be missing for the installed Visual Studio ("No CUDA toolset found").
rem Ninja comes with Visual Studio's C++ CMake tools.
rem
rem Extra arguments go to the configure step, e.g.
rem   build.bat -DWHISPER_DEV_HIP=ON "-DWHISPER_DEV_HIP_TARGETS=gfx1100;gfx1201"
rem set JOBS=n first to limit parallel compiles (CUDA compiles use a lot of memory).
setlocal
cd /d "%~dp0"

if not exist whisper.cpp\include\whisper.h (
  git submodule update --init --recursive || exit /b 1
)

if /i "%VSCMD_ARG_TGT_ARCH%"=="x64" goto have_env
set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
if not exist "%VSWHERE%" (
  echo vswhere.exe not found: install Visual Studio with the C++ workload
  exit /b 1
)
for /f "usebackq tokens=*" %%i in (`"%VSWHERE%" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath`) do set "VSDIR=%%i"
if not defined VSDIR (
  echo Visual Studio with the C++ x64 tools not found
  exit /b 1
)
echo Setting up the x64 build environment of %VSDIR%
call "%VSDIR%\VC\Auxiliary\Build\vcvars64.bat" >nul
if errorlevel 1 exit /b 1
:have_env

where ninja >nul 2>nul
if errorlevel 1 (
  echo ninja not found: install "C++ CMake tools for Windows" in the Visual Studio Installer
  exit /b 1
)

rem A build folder configured with another generator cannot be reused.
if exist build\CMakeCache.txt (
  findstr /c:"CMAKE_GENERATOR:INTERNAL=Ninja Multi-Config" build\CMakeCache.txt >nul
  if errorlevel 1 (
    echo build\ was configured with another generator - removing it
    rmdir /s /q build
  )
)

rem CUDA_ALL: compiled code for the usual GeForce cards (75;86;89;120), as
rem the Linux container build has it. ggml's own list has only PTX for sm_75
rem (RTX 20, GTX 16), which the driver compiles at first use - and refuses
rem when it is older than the toolkit. A -DCUDA_ALL=OFF given here comes
rem later and wins.
cmake -B build -G "Ninja Multi-Config" -DCUDA_ALL=ON %* || exit /b 1
if defined JOBS (
  cmake --build build --config Release -j %JOBS% || exit /b 1
) else (
  cmake --build build --config Release || exit /b 1
)
echo.
echo Libraries are in %~dp0dlls
