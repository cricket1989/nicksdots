#!/usr/bin/sh
req=$(curl -s wttr.in/detroit?format="%t|%l+(%c%f)+%h,+%F")
bar=$(echo $req | awk -F "|" '{print $1}')
tooltip=$(echo $req | awk -F "|" '{print $2}')
echo "{\"text\":\"$bar\", \"tooltip\":\"$tooltip\"}"
