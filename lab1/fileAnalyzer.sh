#!/usr/bin/env bash
folder=$1

output=$2
if [ "$output" == "" ]; then
  output="out"
fi

if [ "$folder" == "" ]; then
  folder=""
fi

out_string="Name,Create data,Size,Extension,Time for video and music"
sp='/-\|'
sc=0
spin() {
    printf "\r${sp:sc++:1} Search files..."
    ((sc==${#sp})) && sc=0
}
endspin() {
    printf '\r%s\n' "$@"
    sleep 0.1
}

echo "Analize files in $folder: "
echo -e $out_string > $output".xls"

while IFS= read -r line; do
  out_string=""
  files_name=($((echo "$line" | awk -F/ '{print $NF}')| awk '{gsub(" ", "_", $0)} 1'))
  sizes=( "$((du -hs "$line" | cut -f1)| awk '{gsub(",", ".", $0)} 1')" )
  datatime=("$(stat -c%.10y "$line")")
  if [ "${files_name#*.}" == "$files_name" ]; then
    types=("unknow")
    video_time=("-")
  else
    types=("${files_name#*.}")
    chk_video=$((ffprobe -v error -show_entries format=duration -of \
     default=noprint_wrappers=1:nokey=1 "$line" 2>&1 | tail -n1)| awk -F': ' '{print $NF}')
    if [[ $chk_video =~ ^[+-]?[0-9]+\.?[0-9]*$ ]] && [ $chk_video != "0.040000" ]; then
      video_time=("$(bc <<< "scale=2; $chk_video/60") Min")
    else
      video_time=("-")
    fi
  fi

  out_string+=${files_name}; out_string+=","
  out_string+=${datatime}; out_string+=","
  out_string+=${sizes}; out_string+=","
  out_string+=${types}; out_string+=","
  out_string+=${video_time};

  spin
  echo -e $out_string >> $output".xls"
  # printf "\b${line}"
done < <(find "$folder" -type f -not -name '.*')

endspin
printf "\nWrite into xls file end\n"
# echo $string
