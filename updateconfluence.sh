#!/bin/bash

confluenceUser="confluence-username"
confluencePass="confluence-user-passowrd"

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
curl -s -u ${confluenceUser}:${confluencePass} -X PUT -H 'Content-Type: application/json' -d '{"id":"33118","type":"page","title":"Test Page","body":{"storage":{"value":"'"${newContent//\"/\\\"}"'","representation":"storage"}},"version":{"number":'"${pageVersion}"'}}' https://blackiron629.atlassian.net/wiki/rest/api/content/33118
