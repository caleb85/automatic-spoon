#!/bin/bash
# requires sed and html2text
# this line pulls the data. Store 71 is sharonville, OH. Currently set to AMD openbox motherboards
curl --cookie "storeSelected=071"  "https://www.microcenter.com/search/search_results.aspx?Ntk=all&sortby=match&prt=clearance&N=4294966996+4294818892&myStore=true" | html2text | sed -n '/\*\*\*\*\* Local Store or Chain Wide Options \*\*\*\*\*/,$p' | sed -n '/\*\*\*\*\* Product Results Pagination \*\*\*\*\*/q;p' | sed 's/ //g' > current.md
#if current.md is blank then echo 0 in stock to the file as well a a random first line.
test -s current.md
fs=$?
if [ $fs = 1 ]; then
    	echo "*****LocalStoreorChainWideOptions*****" >> current.md
    	echo "*0_in_stock_at_Sharonville_store" >> current.md
    	echo "*0_items_found" >> current.md
fi
# This line removes the first line of text that is not needed.
echo "$(tail -n +3 current.md)" > current.md
#if old.md does not exist, create old.md and exit.
test -s old.md
fo=$?
if [ fo = 1]; then
	mv current.md old.md
	exit
fi
cur=$(cat current.md | sed 's/[^0-9]*//g')
old=$(cat old.md | sed 's/[^0-9]*//g')

if [ cur > old ]; then
	echo "current data is larger than the old data a new item is in stock pushbullet notification to phone needed"
elif [ cur < old ]; then
	echo "current data is smaller than the old data  stock has shrunk"
elif [ cur = old ]; then
	echo "stock is the same"
else
	echo "If you see this your are going to have a bad time"
fi
mv current.md old.md
rm current.md
exit