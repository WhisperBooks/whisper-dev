@echo "Dictation Tiny EN Vulkan"
@whisper\whisper-cli2 -m models\ggml-tiny.en.bin -f audio\dictation.mp3 -ng -vk -ts -j > results-cuda-all.jsonl 2>&1
@echo "Dictation Tiny EN Cuda"
@whisper\whisper-cli2 -m models\ggml-tiny.en.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Dictation Base EN Vulkan"
@whisper\whisper-cli2 -m models\ggml-base.en.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Dictation Base EN Cuda"
@whisper\whisper-cli2 -m models\ggml-base.en.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Dictation Small EN Vulkan"
@whisper\whisper-cli2 -m models\ggml-small.en.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Dictation Small EN Cuda"
@whisper\whisper-cli2 -m models\ggml-small.en.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Dictation Medium EN Vulkan"
@whisper\whisper-cli2 -m models\ggml-medium.en.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Dictation Medium EN Cuda"
@whisper\whisper-cli2 -m models\ggml-medium.en.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all.jsonl 2>&1

@echo "Dictation Tiny Vulkan"
@whisper\whisper-cli2 -m models\ggml-tiny.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Dictation Tiny Cuda"
@whisper\whisper-cli2 -m models\ggml-tiny.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Dictation Base Vulkan"
@whisper\whisper-cli2 -m models\ggml-base.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Dictation Base Cuda"
@whisper\whisper-cli2 -m models\ggml-base.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Dictation Small Vulkan"
@whisper\whisper-cli2 -m models\ggml-small.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Dictation Small Cuda"
@whisper\whisper-cli2 -m models\ggml-small.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Dictation Medium Vulkan"
@whisper\whisper-cli2 -m models\ggml-medium.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Dictation Medium Cuda"
@whisper\whisper-cli2 -m models\ggml-medium.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all.jsonl 2>&1

@echo "Dictation Large V1 Vulkan"
@whisper\whisper-cli2 -m models\ggml-large-v1.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Dictation Large V1 Cuda"
@whisper\whisper-cli2 -m models\ggml-large-v1.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Dictation Large V2 Vulkan"
@whisper\whisper-cli2 -m models\ggml-large-v2.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Dictation Large V2 Cuda"
@whisper\whisper-cli2 -m models\ggml-large-v2.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Dictation Large V3 Vulkan"
@whisper\whisper-cli2 -m models\ggml-large-v3.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Dictation Large V3 Cuda"
@whisper\whisper-cli2 -m models\ggml-large-v3.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Dictation Large V3 Turbo Vulkan"
@whisper\whisper-cli2 -m models\ggml-large-v3-turbo.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Dictation Large V3 Turbo Cuda"
@whisper\whisper-cli2 -m models\ggml-large-v3-turbo.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all.jsonl 2>&1

@echo "Aladdin Tiny EN Vulkan"
@whisper\whisper-cli2 -m models\ggml-tiny.en.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Aladdin Tiny EN Cuda"
@whisper\whisper-cli2 -m models\ggml-tiny.en.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Aladdin Base EN Vulkan"
@whisper\whisper-cli2 -m models\ggml-base.en.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Aladdin Base EN Cuda"
@whisper\whisper-cli2 -m models\ggml-base.en.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Aladdin Small EN Vulkan"
@whisper\whisper-cli2 -m models\ggml-small.en.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Aladdin Small EN Cuda"
@whisper\whisper-cli2 -m models\ggml-small.en.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Aladdin Medium EN Vulkan"
@whisper\whisper-cli2 -m models\ggml-medium.en.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Aladdin Medium EN Cuda"
@whisper\whisper-cli2 -m models\ggml-medium.en.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all.jsonl 2>&1

@echo "Aladdin Tiny Vulkan"
@whisper\whisper-cli2 -m models\ggml-tiny.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Aladdin Tiny Cuda"
@whisper\whisper-cli2 -m models\ggml-tiny.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Aladdin Base Vulkan"
@whisper\whisper-cli2 -m models\ggml-base.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Aladdin Base Cuda"
@whisper\whisper-cli2 -m models\ggml-base.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Aladdin Small Vulkan"
@whisper\whisper-cli2 -m models\ggml-small.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Aladdin Small Cuda"
@whisper\whisper-cli2 -m models\ggml-small.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Aladdin Medium Vulkan"
@whisper\whisper-cli2 -m models\ggml-medium.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Aladdin Medium Cuda"
@whisper\whisper-cli2 -m models\ggml-medium.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all.jsonl 2>&1

@echo "Aladdin Large V1 Vulkan"
@whisper\whisper-cli2 -m models\ggml-large-v1.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Aladdin Large V1 Cuda"
@whisper\whisper-cli2 -m models\ggml-large-v1.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Aladdin Large V2 Vulkan"
@whisper\whisper-cli2 -m models\ggml-large-v2.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Aladdin Large V2 Cuda"
@whisper\whisper-cli2 -m models\ggml-large-v2.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Aladdin Large V3 Vulkan"
@whisper\whisper-cli2 -m models\ggml-large-v3.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Aladdin Large V3 Cuda"
@whisper\whisper-cli2 -m models\ggml-large-v3.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Aladdin Large V3 Turbo Vulkan"
@whisper\whisper-cli2 -m models\ggml-large-v3-turbo.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all.jsonl 2>&1
@echo "Aladdin Large V3 Turbo Cuda"
@whisper\whisper-cli2 -m models\ggml-large-v3-turbo.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all.jsonl 2>&1

@echo "Done..."

