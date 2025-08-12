#!/bin/bash
whisper/whisper-cli2 -m models/ggml-medium.en.bin -f audio/dictation.mp3 -ng -cuda
echo "Done..."
