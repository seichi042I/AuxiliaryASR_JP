[ ! -e "jsut_ver1.1.zip" ] && wget http://ss-takashi.sakura.ne.jp/corpus/jsut_ver1.1.zip
[ ! -e "jsut_ver1.1" ] && unzip jsut_ver1.1.zip

# JSUT
source_dir="jsut_ver1.1"
output_dir="jsut_24kHz"
new_dirs=$(find "$source_dir" -type f -name "*.wav" | sed -e "s/\/[^\/]*\.wav//g" | sort -u)
echo $new_dirs
for dir in $new_dirs
do
    echo jsut_24kHz/${dir#*/}
    mkdir -p jsut_24kHz/${dir#*/}
done

# 各 wav ファイルを変換
find "$source_dir" -type f -name "*.wav" | while read -r filename; do
    new_filename="${output_dir}/${filename#*/}"
    [ ! -e $new_filename ] && sox "$filename" -r 24000 "$new_filename"
done

transcript_list=$(find -name "*transcript*.txt" | sort)
[ -e "train_list.txt" ] && rm train_list.txt
for ts in $transcript_list;
do
    for line in $(cat $ts);
    do
        wav_name=${line%:*}
        text=${line##*:}
        curdir=${ts%/*}
        path=${curdir##./}
        # phoneme=$(python pyopenjtalk_g2p.py $text)
        echo "${output_dir}/${path#*/}/wav/${wav_name}.wav|$text|0" >> train_list.txt
    done
done
tail -n 100 train_list.txt > val_list.txt 

# perl -pi -e 'chomp if eof' train_list.txt
# perl -pi -e 'chomp if eof' val_list.txt

cp train_list.txt Data/train_list.txt
cp val_list.txt Data/val_list.txt
