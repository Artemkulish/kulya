#!/bin/bash

test=(one two three)
start="'["
end="]'"
result=""

for word in ${test[@]}
do
  result+="\"${word}\","
done

final_result=$start$result$end
echo $final_result
