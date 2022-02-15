#!/bin/bash
# tmp.txt collects Json payload
# tmp1.txt collects all children urls
#rewards.txt collects all rewards
curl http://algo.work/interview/a > tmp.txt

> reward.txt

function parse {
    x=`jq 'keys | .[0]' tmp.txt | sed 's/\"//g' | uniq | grep "children" | wc -l`
   while [ $x -ge 1 ]
     do
      `jq '.children[]' tmp.txt | sed 's/\"//g' > tmp1.txt`
      `jq -s '.[].reward' tmp.txt >> reward.txt`
      `sed -i -e 's/^/curl /' tmp1.txt`
      `chmod 755 tmp1.txt`
      `./tmp1.txt > tmp.txt`
      y=`jq 'keys | .[0]' tmp.txt | sed 's/\"//g' | uniq | grep "children"`
      if [[ $y == children ]]
      then
      parse
      else
      `jq -s '.[].reward' tmp.txt >> reward.txt`
      sum=`awk '{ sum += $1 } END { print sum }' reward.txt`
      echo "sum of rewards is $sum"
      exit
      fi
     done
}
parse
