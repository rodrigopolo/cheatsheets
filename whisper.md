# whisper.cpp on Apple Silicon

> This guide will install whisper.cpp as a simple transcriber and subtitle generator on macOS with Apple Silicon

Install XCode, then run
```sh
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

Install Conda
```sh
wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-arm64.sh
bash Miniforge3-MacOSX-arm64.sh
```

And if you don't want conda to be activated by default:
```sh
conda config --set auto_activate_base false
```

Then you can activate and deactivate conda:
```sh
conda activate
conda deactivate
```

> [Source](https://docs.conda.io/projects/conda/en/latest/user-guide/install/macos.html)

Set Conda enviroment:
```sh
conda create -n py310-whisper python=3.10 -y
conda activate py310-whisper
```

Install dependencies:
```sh
pip install ane_transformers
pip install openai-whisper
pip install coremltools
```

Clone Whisper:
```sh
cd ~/.apps
git clone https://github.com/ggerganov/whisper.cpp.git && cd whisper.cpp
```

Build for Apple Silicon:
```sh
make clean
WHISPER_COREML=1 make -j
```

Generate and build the model you need, `tiny` works well:
```sh
./models/generate-coreml-model.sh tiny.en && make tiny.en
./models/generate-coreml-model.sh tiny && make tiny
./models/generate-coreml-model.sh base.en && make base.en
./models/generate-coreml-model.sh base && make base
./models/generate-coreml-model.sh small.en && make small.en
./models/generate-coreml-model.sh small && make small
./models/generate-coreml-model.sh medium.en && make medium.en
./models/generate-coreml-model.sh medium && make medium
./models/generate-coreml-model.sh large-v1 && make large-v1
./models/generate-coreml-model.sh large-v2 && make large-v2
./models/generate-coreml-model.sh large-v3 && make large-v3
```

> [Source](https://github.com/ggerganov/whisper.cpp/?tab=readme-ov-file#core-ml-support)

Model file names in `models/` are the following:
```
ggml-tiny.en.bin
ggml-tiny.bin
ggml-base.en.bin
ggml-base.bin
ggml-small.en.bin
ggml-small.bin
ggml-medium.en.bin
ggml-medium.bin
ggml-large-v1.bin
ggml-large-v2.bin
ggml-large-v3.bin
```

Try whisper.cpp with your derired arguments:
```sh
./main \
-m models/ggml-medium.bin \
-l es \
-otxt \
-ovtt \
-osrt \
-olrc \
-owts \
-f /path/to/test.wav
```

To create an audio file compatible with whisper.cpp, you can use FFmpeg:
```sh
ffmpeg \
-i audio.m4a \
-ar 16000 \
-ac 1 \
-c:a pcm_s16le \
test.wav
```

Create the transcribe bash file:
```sh
cd ~/.bin 
touch transcribe
chmod +x transcribe
nano transcribe
```

`transcribe` bash file:
```sh
#!/usr/bin/env bash

# Modifying the internal field separator
IFS=$'\t\n'

if [ -z "$1" ]; then
	echo
	echo  ERROR!
	echo  No input file specified.
	echo
else
	~/.apps/whisper.cpp/main \
	-m ~/.apps/whisper.cpp/models/ggml-tiny.bin \
	-l es \
	-otxt \
	-ovtt \
	-osrt \
	-olrc \
	-owts \
	--print-colors \
	-f "$1"
fi

```

## Alternative

Install Vosk
```sh
conda activate
pip install vosk
```

Help and models
```sh
vosk-transcriber --help
vosk-transcriber --list-model
```

Do a transcription to SRT, using the Espanish module, with `warn` log level
```sh
vosk-transcriber \
-n vosk-model-es-0.42 \
--log-level warn \
-i "audio.m4a" \
-t srt \
-o transcription.srt
```

Extra notes:
* [9 free AI tools that run locally on your PC](https://www.pcworld.com/article/2064105/9-free-ai-tools-that-run-locally-on-the-pc.html)
* [Benchmarking Top Open Source Speech Recognition Models: Whisper, Facebook wav2vec2, and Kaldi](https://deepgram.com/learn/benchmarking-top-open-source-speech-models)

