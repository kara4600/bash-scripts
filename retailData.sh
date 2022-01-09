#/!/bin/bash

if [[ $1 ]]; then

fileName=$1

#Creates a temp CSV file with the data cleaned up and header line removed
tail -n +2 $fileName | sed -e '/^[^,]*,[^,]*,[^,]*,Discount/d' -e '/^[^,]*,[^,]*,[^,]*[^,]*,[^,]*,[^,]*,[^,]*,[^,]*,Champion/d' -e '/^[^,]*,[^,]*POST/d' -e '/^C/d' -e 's/\(".*\),\(.*"\)/\1\2/g' > cleanTemp.csv

#Goes through for each brand and calculates the required values then prints them
awk -F "," 'BEGIN {printf "%-15s %-15s %s\n %s\n","Company","Gross Sales","Items Under $2.00","------------------------------------------------"} $8 ~ /CDG/ {sum += ($4 * $6)} ; ($8 ~ /CDG/ && ($6 < 2.00)) {tot += 1} END {printf "%-15s %-15s %s\n", "CDG", sum, tot}' cleanTemp.csv

awk -F "," '$8 ~ /Nike/ {sum += ($4 * $6)} ; ($8 ~ /Nike/ && ($6 < 2.00)) {tot += 1} END {printf "%-15s %-15s %s\n", "Nike", sum, tot}' cleanTemp.csv

awk -F "," '$8 ~ /Thrasher/ {sum += ($4 * $6)} ; ($8 ~ /Thrasher/ && ($6 < 2.00)) {tot += 1} END {printf "%-15s %-15s %s\n", "Thrasher", sum, tot}' cleanTemp.csv

awk -F "," '$8 ~ /Vans/ {sum += ($4 * $6)} ; ($8 ~ /Vans/ && ($6 < 2.00)) {tot += 1} END {printf "%-15s %-15s %s\n", "Vans", sum, tot}' cleanTemp.csv

#After the temp file is used to collect the data, it is deleted
awk -F "," '$8 ~ /Brandy Melville/ {sum += ($4 * $6)} ; ($8 ~ /Brandy Melville/ && ($6 < 2.00)) {tot += 1} END {printf "%-15s %-15s %s\n", "Brandy Melville", sum, tot; system("rm cleanTemp.csv")}' cleanTemp.csv

else
echo "Invalid command usage. Try ./retailData.sh <fileName>"
fi
