#!/bin/bash
whisper/whisper-cli2 -m models/ggml-medium.en.bin -f audio/dictation.mp3 -ng -openvino -ts -j > results-cpu.jsonl 2>&1
whisper/whisper-cli2 -m models/ggml-medium.en.bin -f audio/aladdin.mp3 -ng -openvino -ts -j >> results-cpu.jsonl 2>&1
echo "Done..."

