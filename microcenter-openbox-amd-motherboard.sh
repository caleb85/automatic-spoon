#!/bin/bash
# requires sed and html2text
# this line pulls the data. Store 71 is sharonville, OH. Currently set to computer
curl --cookie "storeSelected=071"  "https://www.microcenter.com/search/search_results.aspx?Ntk=all&sortby=match&prt=clearance&N=4294966996+4294818892&myStore=true" | html2text | sed -n '/\*\*\*\*\* Local Store or Chain Wide Options \*\*\*\*\*/,$p' | sed -n '/\*\*\*\*\* Product Results Pagination \*\*\*\*\*/q;p' > current.md
if current.md is blank then echo 0 in stock to the file as well a a random first line.
# This line removes the first line of text that is not needed.
echo "$(tail -n +2 current.md)" > current.md

#compare the data from test1 and test2.md
if old.md does not exist, create old.md and exit.
If old.md does exist, compare the number of items in stock with current.md and old.md 
	If current.md items in stock are larger than the ones in old.md
		sent a push bullet notification to your phone
		else exit
remove old.md
rename current.md to old.md
exit