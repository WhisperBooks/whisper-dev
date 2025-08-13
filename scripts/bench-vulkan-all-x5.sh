# #!/bin/bash
echo "Pass 1"
echo "Dictation Tiny EN Vulkan"
whisper/whisper-cli2 -m models/ggml-tiny.en.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Base EN Vulkan"
whisper/whisper-cli2 -m models/ggml-base.en.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Small EN Vulkan"
whisper/whisper-cli2 -m models/ggml-small.en.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Medium EN Vulkan"
whisper/whisper-cli2 -m models/ggml-medium.en.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1

echo "Dictation Tiny Vulkan"
whisper/whisper-cli2 -m models/ggml-tiny.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Base Vulkan"
whisper/whisper-cli2 -m models/ggml-base.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Small Vulkan"
whisper/whisper-cli2 -m models/ggml-small.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Medium Vulkan"
whisper/whisper-cli2 -m models/ggml-medium.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1

echo "Dictation Large V1 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v1.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Large V2 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v2.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Large V3 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v3.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Large V3 Turbo Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v3-turbo.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1

echo "Aladdin Tiny EN Vulkan"
whisper/whisper-cli2 -m models/ggml-tiny.en.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Base EN Vulkan"
whisper/whisper-cli2 -m models/ggml-base.en.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Small EN Vulkan"
whisper/whisper-cli2 -m models/ggml-small.en.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Medium EN Vulkan"
whisper/whisper-cli2 -m models/ggml-medium.en.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1

echo "Aladdin Tiny Vulkan"
whisper/whisper-cli2 -m models/ggml-tiny.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Base Vulkan"
whisper/whisper-cli2 -m models/ggml-base.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Small Vulkan"
whisper/whisper-cli2 -m models/ggml-small.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Medium Vulkan"
whisper/whisper-cli2 -m models/ggml-medium.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1

echo "Aladdin Large V1 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v1.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Large V2 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v2.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Large V3 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v3.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Large V3 Turbo Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v3-turbo.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1



echo "Pass 2"
echo "Dictation Tiny EN Vulkan"
whisper/whisper-cli2 -m models/ggml-tiny.en.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Base EN Vulkan"
whisper/whisper-cli2 -m models/ggml-base.en.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Small EN Vulkan"
whisper/whisper-cli2 -m models/ggml-small.en.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Medium EN Vulkan"
whisper/whisper-cli2 -m models/ggml-medium.en.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1

echo "Dictation Tiny Vulkan"
whisper/whisper-cli2 -m models/ggml-tiny.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Base Vulkan"
whisper/whisper-cli2 -m models/ggml-base.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Small Vulkan"
whisper/whisper-cli2 -m models/ggml-small.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Medium Vulkan"
whisper/whisper-cli2 -m models/ggml-medium.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1

echo "Dictation Large V1 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v1.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Large V2 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v2.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Large V3 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v3.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Large V3 Turbo Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v3-turbo.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1

echo "Aladdin Tiny EN Vulkan"
whisper/whisper-cli2 -m models/ggml-tiny.en.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Base EN Vulkan"
whisper/whisper-cli2 -m models/ggml-base.en.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Small EN Vulkan"
whisper/whisper-cli2 -m models/ggml-small.en.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Medium EN Vulkan"
whisper/whisper-cli2 -m models/ggml-medium.en.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1

echo "Aladdin Tiny Vulkan"
whisper/whisper-cli2 -m models/ggml-tiny.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Base Vulkan"
whisper/whisper-cli2 -m models/ggml-base.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Small Vulkan"
whisper/whisper-cli2 -m models/ggml-small.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Medium Vulkan"
whisper/whisper-cli2 -m models/ggml-medium.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1

echo "Aladdin Large V1 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v1.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Large V2 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v2.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Large V3 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v3.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Large V3 Turbo Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v3-turbo.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1



echo "Pass 3"
echo "Dictation Tiny EN Vulkan"
whisper/whisper-cli2 -m models/ggml-tiny.en.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Base EN Vulkan"
whisper/whisper-cli2 -m models/ggml-base.en.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Small EN Vulkan"
whisper/whisper-cli2 -m models/ggml-small.en.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Medium EN Vulkan"
whisper/whisper-cli2 -m models/ggml-medium.en.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1

echo "Dictation Tiny Vulkan"
whisper/whisper-cli2 -m models/ggml-tiny.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Base Vulkan"
whisper/whisper-cli2 -m models/ggml-base.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Small Vulkan"
whisper/whisper-cli2 -m models/ggml-small.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Medium Vulkan"
whisper/whisper-cli2 -m models/ggml-medium.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1

echo "Dictation Large V1 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v1.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Large V2 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v2.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Large V3 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v3.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Large V3 Turbo Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v3-turbo.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1

echo "Aladdin Tiny EN Vulkan"
whisper/whisper-cli2 -m models/ggml-tiny.en.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Base EN Vulkan"
whisper/whisper-cli2 -m models/ggml-base.en.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Small EN Vulkan"
whisper/whisper-cli2 -m models/ggml-small.en.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Medium EN Vulkan"
whisper/whisper-cli2 -m models/ggml-medium.en.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1

echo "Aladdin Tiny Vulkan"
whisper/whisper-cli2 -m models/ggml-tiny.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Base Vulkan"
whisper/whisper-cli2 -m models/ggml-base.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Small Vulkan"
whisper/whisper-cli2 -m models/ggml-small.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Medium Vulkan"
whisper/whisper-cli2 -m models/ggml-medium.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1

echo "Aladdin Large V1 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v1.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Large V2 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v2.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Large V3 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v3.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Large V3 Turbo Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v3-turbo.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1



echo "Pass 4"
echo "Dictation Tiny EN Vulkan"
whisper/whisper-cli2 -m models/ggml-tiny.en.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Base EN Vulkan"
whisper/whisper-cli2 -m models/ggml-base.en.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Small EN Vulkan"
whisper/whisper-cli2 -m models/ggml-small.en.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Medium EN Vulkan"
whisper/whisper-cli2 -m models/ggml-medium.en.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1

echo "Dictation Tiny Vulkan"
whisper/whisper-cli2 -m models/ggml-tiny.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Base Vulkan"
whisper/whisper-cli2 -m models/ggml-base.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Small Vulkan"
whisper/whisper-cli2 -m models/ggml-small.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Medium Vulkan"
whisper/whisper-cli2 -m models/ggml-medium.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1

echo "Dictation Large V1 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v1.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Large V2 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v2.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Large V3 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v3.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Large V3 Turbo Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v3-turbo.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1

echo "Aladdin Tiny EN Vulkan"
whisper/whisper-cli2 -m models/ggml-tiny.en.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Base EN Vulkan"
whisper/whisper-cli2 -m models/ggml-base.en.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Small EN Vulkan"
whisper/whisper-cli2 -m models/ggml-small.en.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Medium EN Vulkan"
whisper/whisper-cli2 -m models/ggml-medium.en.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1

echo "Aladdin Tiny Vulkan"
whisper/whisper-cli2 -m models/ggml-tiny.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Base Vulkan"
whisper/whisper-cli2 -m models/ggml-base.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Small Vulkan"
whisper/whisper-cli2 -m models/ggml-small.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Medium Vulkan"
whisper/whisper-cli2 -m models/ggml-medium.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1

echo "Aladdin Large V1 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v1.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Large V2 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v2.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Large V3 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v3.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Large V3 Turbo Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v3-turbo.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1



echo "Pass 5"
echo "Dictation Tiny EN Vulkan"
whisper/whisper-cli2 -m models/ggml-tiny.en.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Base EN Vulkan"
whisper/whisper-cli2 -m models/ggml-base.en.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Small EN Vulkan"
whisper/whisper-cli2 -m models/ggml-small.en.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Medium EN Vulkan"
whisper/whisper-cli2 -m models/ggml-medium.en.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1

echo "Dictation Tiny Vulkan"
whisper/whisper-cli2 -m models/ggml-tiny.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Base Vulkan"
whisper/whisper-cli2 -m models/ggml-base.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Small Vulkan"
whisper/whisper-cli2 -m models/ggml-small.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Medium Vulkan"
whisper/whisper-cli2 -m models/ggml-medium.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1

echo "Dictation Large V1 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v1.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Large V2 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v2.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Large V3 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v3.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Dictation Large V3 Turbo Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v3-turbo.bin -f audio/dictation.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1

echo "Aladdin Tiny EN Vulkan"
whisper/whisper-cli2 -m models/ggml-tiny.en.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Base EN Vulkan"
whisper/whisper-cli2 -m models/ggml-base.en.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Small EN Vulkan"
whisper/whisper-cli2 -m models/ggml-small.en.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Medium EN Vulkan"
whisper/whisper-cli2 -m models/ggml-medium.en.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1

echo "Aladdin Tiny Vulkan"
whisper/whisper-cli2 -m models/ggml-tiny.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Base Vulkan"
whisper/whisper-cli2 -m models/ggml-base.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Small Vulkan"
whisper/whisper-cli2 -m models/ggml-small.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Medium Vulkan"
whisper/whisper-cli2 -m models/ggml-medium.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1

echo "Aladdin Large V1 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v1.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Large V2 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v2.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Large V3 Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v3.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1
echo "Aladdin Large V3 Turbo Vulkan"
whisper/whisper-cli2 -m models/ggml-large-v3-turbo.bin -f audio/aladdin.mp3 -ng -vk -ts -j >> results-vulkan-all-x5.jsonl 2>&1



echo "Done..."

