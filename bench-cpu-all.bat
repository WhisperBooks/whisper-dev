@echo "Dictation Tiny EN OpenVINO"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.en.bin -f audio\dictation.mp3 -ng -openvino -ts -j >> results-cpu-all.jsonl 2>&1
@echo "Dictation Base EN OpenVINO"
@build\bin\Release\whisper-cli2 -m models\ggml-base.en.bin -f audio\dictation.mp3 -ng -openvino -ts -j >> results-cpu-all.jsonl 2>&1
@echo "Dictation Small EN OpenVINO"
@build\bin\Release\whisper-cli2 -m models\ggml-small.en.bin -f audio\dictation.mp3 -ng -openvino -ts -j >> results-cpu-all.jsonl 2>&1
@echo "Dictation Medium EN OpenVINO"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.en.bin -f audio\dictation.mp3 -ng -openvino -ts -j >> results-cpu-all.jsonl 2>&1

@echo "Dictation Tiny OpenVINO"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.bin -f audio\dictation.mp3 -ng -openvino -ts -j >> results-cpu-all.jsonl 2>&1
@echo "Dictation Base OpenVINO"
@build\bin\Release\whisper-cli2 -m models\ggml-base.bin -f audio\dictation.mp3 -ng -openvino -ts -j >> results-cpu-all.jsonl 2>&1
@echo "Dictation Small OpenVINO"
@build\bin\Release\whisper-cli2 -m models\ggml-small.bin -f audio\dictation.mp3 -ng -openvino -ts -j >> results-cpu-all.jsonl 2>&1
@echo "Dictation Medium OpenVINO"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.bin -f audio\dictation.mp3 -ng -openvino -ts -j >> results-cpu-all.jsonl 2>&1

@echo "Dictation Large V1 OpenVINO"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v1.bin -f audio\dictation.mp3 -ng -openvino -ts -j >> results-cpu-all.jsonl 2>&1
@echo "Dictation Large V2 OpenVINO"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v2.bin -f audio\dictation.mp3 -ng -openvino -ts -j >> results-cpu-all.jsonl 2>&1
@echo "Dictation Large V3 OpenVINO"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3.bin -f audio\dictation.mp3 -ng -openvino -ts -j >> results-cpu-all.jsonl 2>&1
@echo "Dictation Large V3 Turbo OpenVINO"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3-turbo.bin -f audio\dictation.mp3 -ng -openvino -ts -j >> results-cpu-all.jsonl 2>&1

@echo "Aladdin Tiny EN OpenVINO"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.en.bin -f audio\aladdin.mp3 -ng -openvino -ts -j >> results-cpu-all.jsonl 2>&1
@echo "Aladdin Base EN OpenVINO"
@build\bin\Release\whisper-cli2 -m models\ggml-base.en.bin -f audio\aladdin.mp3 -ng -openvino -ts -j >> results-cpu-all.jsonl 2>&1
@echo "Aladdin Small EN OpenVINO"
@build\bin\Release\whisper-cli2 -m models\ggml-small.en.bin -f audio\aladdin.mp3 -ng -openvino -ts -j >> results-cpu-all.jsonl 2>&1
@echo "Aladdin Medium EN OpenVINO"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.en.bin -f audio\aladdin.mp3 -ng -openvino -ts -j >> results-cpu-all.jsonl 2>&1

@echo "Aladdin Tiny OpenVINO"
@build\bin\Release\whisper-cli2 -m models\ggml-tiny.bin -f audio\aladdin.mp3 -ng -openvino -ts -j >> results-cpu-all.jsonl 2>&1
@echo "Aladdin Base OpenVINO"
@build\bin\Release\whisper-cli2 -m models\ggml-base.bin -f audio\aladdin.mp3 -ng -openvino -ts -j >> results-cpu-all.jsonl 2>&1
@echo "Aladdin Small OpenVINO"
@build\bin\Release\whisper-cli2 -m models\ggml-small.bin -f audio\aladdin.mp3 -ng -openvino -ts -j >> results-cpu-all.jsonl 2>&1
@echo "Aladdin Medium OpenVINO"
@build\bin\Release\whisper-cli2 -m models\ggml-medium.bin -f audio\aladdin.mp3 -ng -openvino -ts -j >> results-cpu-all.jsonl 2>&1

@echo "Aladdin Large V1 OpenVINO"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v1.bin -f audio\aladdin.mp3 -ng -openvino -ts -j >> results-cpu-all.jsonl 2>&1
@echo "Aladdin Large V2 OpenVINO"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v2.bin -f audio\aladdin.mp3 -ng -openvino -ts -j >> results-cpu-all.jsonl 2>&1
@echo "Aladdin Large V3 OpenVINO"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3.bin -f audio\aladdin.mp3 -ng -openvino -ts -j >> results-cpu-all.jsonl 2>&1
@echo "Aladdin Large V3 Turbo OpenVINO"
@build\bin\Release\whisper-cli2 -m models\ggml-large-v3-turbo.bin -f audio\aladdin.mp3 -ng -openvino -ts -j >> results-cpu-all.jsonl 2>&1

@echo "Done..."

