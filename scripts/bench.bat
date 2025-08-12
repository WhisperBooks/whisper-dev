@whisper\whisper-cli2 -m models\ggml-medium.en.bin -f audio\dictation.mp3 -ng -vk -ts -j > results-cuda.jsonl 2>&1
@whisper\whisper-cli2 -m models\ggml-medium.en.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda.jsonl 2>&1
@whisper\whisper-cli2 -m models\ggml-medium.en.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda.jsonl 2>&1
@whisper\whisper-cli2 -m models\ggml-medium.en.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda.jsonl 2>&1
@echo "Done..."