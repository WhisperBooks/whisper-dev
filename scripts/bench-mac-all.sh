#!/bin/bash
echo "Dictation Tiny EN mac"
whisper/whisper-cli2 -m models/ggml-tiny.en.bin -f audio/dictation.mp3 -ng -coreml -ts -j > results-mac-all.jsonl 2>&1
echo "Dictation Base EN mac"
whisper/whisper-cli2 -m models/ggml-base.en.bin -f audio/dictation.mp3 -ng -coreml -ts -j >> results-mac-all.jsonl 2>&1
echo "Dictation Small EN mac"
whisper/whisper-cli2 -m models/ggml-small.en.bin -f audio/dictation.mp3 -ng -coreml -ts -j >> results-mac-all.jsonl 2>&1
echo "Dictation Medium EN mac"
whisper/whisper-cli2 -m models/ggml-medium.en.bin -f audio/dictation.mp3 -ng -coreml -ts -j >> results-mac-all.jsonl 2>&1
echo "Dictation Tiny mac"
whisper/whisper-cli2 -m models/ggml-tiny.bin -f audio/dictation.mp3 -ng -coreml -ts -j >> results-mac-all.jsonl 2>&1
echo "Dictation Base mac"
whisper/whisper-cli2 -m models/ggml-base.bin -f audio/dictation.mp3 -ng -coreml -ts -j >> results-mac-all.jsonl 2>&1
echo "Dictation Small mac"
whisper/whisper-cli2 -m models/ggml-small.bin -f audio/dictation.mp3 -ng -coreml -ts -j >> results-mac-all.jsonl 2>&1
echo "Dictation Medium mac"
whisper/whisper-cli2 -m models/ggml-medium.bin -f audio/dictation.mp3 -ng -coreml -ts -j >> results-mac-all.jsonl 2>&1
echo "Dictation Large V1 mac"
whisper/whisper-cli2 -m models/ggml-large-v1.bin -f audio/dictation.mp3 -ng -coreml -ts -j >> results-mac-all.jsonl 2>&1
echo "Dictation Large V2 mac"
whisper/whisper-cli2 -m models/ggml-large-v2.bin -f audio/dictation.mp3 -ng -coreml -ts -j >> results-mac-all.jsonl 2>&1
echo "Dictation Large V3 mac"
whisper/whisper-cli2 -m models/ggml-large-v3.bin -f audio/dictation.mp3 -ng -coreml -ts -j >> results-mac-all.jsonl 2>&1
echo "Dictation Large V3 Turbo mac"
whisper/whisper-cli2 -m models/ggml-large-v3-turbo.bin -f audio/dictation.mp3 -ng -coreml -ts -j >> results-mac-all.jsonl 2>&1

echo "Aladdin Tiny EN mac"
whisper/whisper-cli2 -m models/ggml-tiny.en.bin -f audio/aladdin.mp3 -ng -coreml -ts -j >> results-mac-all.jsonl 2>&1
echo "Aladdin Base EN mac"
whisper/whisper-cli2 -m models/ggml-base.en.bin -f audio/aladdin.mp3 -ng -coreml -ts -j >> results-mac-all.jsonl 2>&1
echo "Aladdin Small EN mac"
whisper/whisper-cli2 -m models/ggml-small.en.bin -f audio/aladdin.mp3 -ng -coreml -ts -j >> results-mac-all.jsonl 2>&1
echo "Aladdin Medium EN mac"
whisper/whisper-cli2 -m models/ggml-medium.en.bin -f audio/aladdin.mp3 -ng -coreml -ts -j >> results-mac-all.jsonl 2>&1
echo "Aladdin Tiny mac"
whisper/whisper-cli2 -m models/ggml-tiny.bin -f audio/aladdin.mp3 -ng -coreml -ts -j >> results-mac-all.jsonl 2>&1
echo "Aladdin Base mac"
whisper/whisper-cli2 -m models/ggml-base.bin -f audio/aladdin.mp3 -ng -coreml -ts -j >> results-mac-all.jsonl 2>&1
echo "Aladdin Small mac"
whisper/whisper-cli2 -m models/ggml-small.bin -f audio/aladdin.mp3 -ng -coreml -ts -j >> results-mac-all.jsonl 2>&1
echo "Aladdin Medium mac"
whisper/whisper-cli2 -m models/ggml-medium.bin -f audio/aladdin.mp3 -ng -coreml -ts -j >> results-mac-all.jsonl 2>&1
echo "Aladdin Large V1 mac"
whisper/whisper-cli2 -m models/ggml-large-v1.bin -f audio/aladdin.mp3 -ng -coreml -ts -j >> results-mac-all.jsonl 2>&1
echo "Aladdin Large V2 mac"
whisper/whisper-cli2 -m models/ggml-large-v2.bin -f audio/aladdin.mp3 -ng -coreml -ts -j >> results-mac-all.jsonl 2>&1
echo "Aladdin Large V3 mac"
whisper/whisper-cli2 -m models/ggml-large-v3.bin -f audio/aladdin.mp3 -ng -coreml -ts -j >> results-mac-all.jsonl 2>&1
echo "Aladdin Large V3 Turbo mac"
whisper/whisper-cli2 -m models/ggml-large-v3-turbo.bin -f audio/aladdin.mp3 -ng -coreml -ts -j >> results-mac-all.jsonl 2>&1

echo "Done..."

