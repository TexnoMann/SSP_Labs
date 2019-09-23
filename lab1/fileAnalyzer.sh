#!/usr/bin/env bash
files_name=(); sizes=(); format=(); datatime=(); types=(); video_time=()
folder=$1

vid_chk_str_1='Invalid data found when processing input'
vid_chk_str_2='Invalid argument'

while IFS= read -r line; do
  files_name+=($((echo "$line" | awk -F/ '{print $NF}')| awk '{gsub(" ", "_", $0)} 1'))
  sizes+=( "$((du -hs "$line" | cut -f1)| awk '{gsub(",", ".", $0)} 1')" )
  datatime+=("$(stat -c%.10y "$line")")
  if [ "${line#*.}" == "$line" ]; then
    types+=("unknow")
    video_time+=("-")
  else
    types+=("${line#*.}")
    check_line=$((ffmpeg -v error -i $line 2>&1 | tail -n1)| awk -F': ' '{print $NF}')
    if [ "${check_line}" == "$vid_chk_str_1" ] || [ "${check_line}" == "$vid_chk_str_2" ]; then
      video_time+=("-")
    else
      video_time+=("$(bc <<< "scale=2; $(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$line")/60") Min")
    fi
  fi
done < <(find $folder -type f -not -name '.*')
echo 'List of files:'
echo ${files_name[@]}
echo 'List of sizes:'
echo ${sizes[@]}
echo 'List of datas:'
echo ${datatime[@]}
echo 'List of types:'
echo ${types[@]}
echo 'List of video/music times:'
echo ${video_time[@]}
len_list=${#files_name[@]}
string="filename,data create,size of file(byte),type,duration(video music)\n"
for ((i=0;i<len_list;++i))
do
  string+=${files_name[i]}; string+=","
  string+=${datatime[i]}; string+=","
  string+=${sizes[i]}; string+=","
  string+=${types[i]}; string+=","
  string+=${video_time[i]}; string+="\n"
  # echo $string
done
printf "\nWrite into csv:\n"
echo $string
echo -e $string >.temp.csv
 ssconvert .temp.csv $2
rm .temp.csv
