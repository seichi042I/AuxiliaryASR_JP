# AuxiliaryASR
このレポには、[StarGANv2-VC](https://github.com/yl4579/StarGANv2-VC)と[StyleTTS](https://github.com/yl4579/StyleTTS)で使用されている音声変換（VC）とTTS（Text-Mel Alignment）のための音素レベルASRのトレーニングコードが含まれています。

## 前提条件
1. Python >= 3.7
2. Clone this repository:
```bash
git clone https://github.com/seichi042I/AuxiliaryASR_JP
cd AuxiliaryASR_JP
```

## 学習
```bash
chmod +x run.sh
./run.sh
```
このコマンドを実行するだけで事前準備から学習まで実行してくれます。
最大24GBのGPU VRAMを消費します。メモリ不足エラーが発生する場合は、`Configs/config.yml`の`batch_size`を減らして下さい。

## 参考
- [NVIDIA/tacotron2](https://github.com/NVIDIA/tacotron2)
- [kan-bayashi/ParallelWaveGAN](https://github.com/kan-bayashi/ParallelWaveGAN)
- [改変元のリポジトリ](https://github.com/yl4579/AuxiliaryASR)
