numgrupos=$(az.cmd group list | jq ".[].name" | wc -l)

for i in `seq 1 $numgrupos`
do
  rg=$(az.cmd group list | jq ".[$i-1].name") 
  rg=$(echo $rg | sed 's/"//g')
  echo $rg  
  az.cmd group update -n $rg --set tags.Environment=Test tags.Dept=IT  
done