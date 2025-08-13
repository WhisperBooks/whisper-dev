@echo "Pass 1"
@echo "Dictation Tiny EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.en.bin -f audio\dictation.mp3 -ng -vk -ts -j > results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Tiny EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.en.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Base EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-base.en.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Base EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-base.en.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Small EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-small.en.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Small EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-small.en.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Medium EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.en.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Medium EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.en.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Dictation Tiny Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Tiny Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Base Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-base.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Base Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-base.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Small Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-small.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Small Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-small.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Medium Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Medium Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Dictation Large V1 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v1.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V1 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v1.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V2 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v2.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V2 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v2.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V3 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V3 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V3 Turbo Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3-turbo.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V3 Turbo Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3-turbo.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Aladdin Tiny EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.en.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Tiny EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.en.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Base EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-base.en.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Base EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-base.en.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Small EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-small.en.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Small EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-small.en.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Medium EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.en.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Medium EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.en.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Aladdin Tiny Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Tiny Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Base Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-base.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Base Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-base.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Small Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-small.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Small Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-small.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Medium Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Medium Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Aladdin Large V1 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v1.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V1 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v1.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V2 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v2.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V2 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v2.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V3 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V3 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V3 Turbo Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3-turbo.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V3 Turbo Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3-turbo.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Pass 2"
@echo "Dictation Tiny EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.en.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Tiny EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.en.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Base EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-base.en.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Base EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-base.en.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Small EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-small.en.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Small EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-small.en.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Medium EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.en.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Medium EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.en.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Dictation Tiny Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Tiny Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Base Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-base.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Base Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-base.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Small Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-small.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Small Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-small.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Medium Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Medium Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Dictation Large V1 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v1.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V1 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v1.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V2 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v2.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V2 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v2.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V3 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V3 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V3 Turbo Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3-turbo.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V3 Turbo Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3-turbo.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Aladdin Tiny EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.en.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Tiny EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.en.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Base EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-base.en.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Base EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-base.en.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Small EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-small.en.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Small EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-small.en.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Medium EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.en.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Medium EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.en.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Aladdin Tiny Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Tiny Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Base Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-base.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Base Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-base.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Small Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-small.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Small Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-small.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Medium Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Medium Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Aladdin Large V1 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v1.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V1 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v1.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V2 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v2.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V2 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v2.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V3 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V3 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V3 Turbo Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3-turbo.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V3 Turbo Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3-turbo.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Pass 3"
@echo "Dictation Tiny EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.en.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Tiny EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.en.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Base EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-base.en.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Base EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-base.en.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Small EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-small.en.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Small EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-small.en.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Medium EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.en.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Medium EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.en.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Dictation Tiny Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Tiny Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Base Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-base.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Base Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-base.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Small Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-small.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Small Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-small.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Medium Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Medium Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Dictation Large V1 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v1.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V1 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v1.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V2 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v2.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V2 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v2.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V3 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V3 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V3 Turbo Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3-turbo.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V3 Turbo Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3-turbo.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Aladdin Tiny EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.en.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Tiny EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.en.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Base EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-base.en.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Base EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-base.en.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Small EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-small.en.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Small EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-small.en.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Medium EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.en.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Medium EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.en.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Aladdin Tiny Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Tiny Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Base Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-base.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Base Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-base.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Small Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-small.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Small Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-small.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Medium Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Medium Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Aladdin Large V1 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v1.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V1 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v1.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V2 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v2.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V2 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v2.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V3 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V3 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V3 Turbo Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3-turbo.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V3 Turbo Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3-turbo.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Pass 4"
@echo "Dictation Tiny EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.en.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Tiny EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.en.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Base EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-base.en.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Base EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-base.en.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Small EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-small.en.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Small EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-small.en.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Medium EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.en.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Medium EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.en.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Dictation Tiny Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Tiny Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Base Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-base.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Base Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-base.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Small Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-small.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Small Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-small.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Medium Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Medium Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Dictation Large V1 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v1.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V1 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v1.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V2 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v2.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V2 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v2.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V3 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V3 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V3 Turbo Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3-turbo.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V3 Turbo Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3-turbo.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Aladdin Tiny EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.en.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Tiny EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.en.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Base EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-base.en.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Base EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-base.en.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Small EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-small.en.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Small EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-small.en.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Medium EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.en.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Medium EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.en.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Aladdin Tiny Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Tiny Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Base Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-base.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Base Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-base.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Small Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-small.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Small Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-small.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Medium Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Medium Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Aladdin Large V1 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v1.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V1 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v1.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V2 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v2.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V2 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v2.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V3 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V3 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V3 Turbo Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3-turbo.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V3 Turbo Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3-turbo.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Pass 5"
@echo "Dictation Tiny EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.en.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Tiny EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.en.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Base EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-base.en.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Base EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-base.en.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Small EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-small.en.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Small EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-small.en.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Medium EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.en.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Medium EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.en.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Dictation Tiny Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Tiny Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Base Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-base.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Base Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-base.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Small Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-small.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Small Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-small.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Medium Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Medium Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Dictation Large V1 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v1.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V1 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v1.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V2 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v2.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V2 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v2.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V3 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V3 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V3 Turbo Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3-turbo.bin -f audio\dictation.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Dictation Large V3 Turbo Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3-turbo.bin -f audio\dictation.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Aladdin Tiny EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.en.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Tiny EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.en.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Base EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-base.en.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Base EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-base.en.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Small EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-small.en.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Small EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-small.en.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Medium EN Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.en.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Medium EN Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.en.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Aladdin Tiny Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Tiny Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Base Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-base.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Base Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-base.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Small Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-small.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Small Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-small.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Medium Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Medium Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Aladdin Large V1 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v1.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V1 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v1.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V2 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v2.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V2 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v2.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V3 Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V3 Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V3 Turbo Vulkan"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3-turbo.bin -f audio\aladdin.mp3 -ng -vk -ts -j >> results-cuda-all-x5.jsonl 2>&1
@echo "Aladdin Large V3 Turbo Cuda"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3-turbo.bin -f audio\aladdin.mp3 -ng -cuda -ts -j >> results-cuda-all-x5.jsonl 2>&1

@echo "Done..."

