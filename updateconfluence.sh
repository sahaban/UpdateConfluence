#!/bin/bash

confluenceUser="emv52697@zslsz.com"
confluencePass=":ATATT3xFfGF0tcjYKcj1BzqTH68_mopLKmo8N710lpWKQGpI-WPBBp8pPUkOp3gvANo-gYAbFUeW9ISmq1FXYZfPH23AvQ7YIgrSOmdUKPR_B6sWB36qvbZA2Jk8oOrXkmeWrsL8GcS5qt2LuID8S1ScdK3zg-0j31VHVXx1FVVxODnzCLdhWnA=3634A4ED"

#get current whole page content from confluence
currentContent=`curl -s -u ${confluenceUser}:${confluencePass} -X GET https://blackiron629.atlassian.net/wiki/rest/api/content/33118?expand=body.storage | python3 -c "import sys, json; print json.load(sys.stdin)['body']['storage']['value']"`
#If you manually modify the confluence page it will introdure few junk characters like "colspan="1"". Hence we are replacing them with blank
Old=' colspan="1"'
New=''

#Current content of the confluence page after cleanup
currentContent=${currentContent//$Old/$New}

oldRow="</tbody></table>"
newRow=$1
newContent="${currentContent/$oldRow/$newRow}"

pageVersion=`curl -s -u ${confluenceUser}:${confluencePass} -X GET https://blackiron629.atlassian.net/wiki/rest/api/content/33118?expand=version | python3 -c "import sys, json; print json.load(sys.stdin)['version']['number']"+1`
echo "pageVersion: ${pageVersion}"

#Update the page with new table  row
curl -s -u ${confluenceUser}:${confluencePass} -X PUT -H 'Content-Type: application/json' -d '{"id":"1396984912","type":"page","title":"Jenkins_to_Confluence1","body":{"storage":{"value":"'"${newContent//\"/\\\"}"'","representation":"storage"}},"version":{"number":'"${pageVersion}"'}}' https://blackiron629.atlassian.net/wiki/rest/api/content/33118