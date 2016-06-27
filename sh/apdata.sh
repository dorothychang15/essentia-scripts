#!/bin/sh
# processes average price data from labor stats

echo "set cluster to local"
ess cluster set local
echo "select asi-opendata bucket"
ess select s3://asi-opendata --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
echo "create ap_data category"
ess category add ap_data 'LaborStats/time.series/ap/ap.data.*' --dateregex=none --delimiter=tab --preprocess='aq_pp -f,+1,eok,qui,tsv - -d S,TRM:series_id I:year S:period F,TRM:value X:' --overwrite
echo "show summary of ap_data category"
ess summary ap_data
echo "query: count number of years covered in ap_data"
ess query 'select count(distinct year) from ap_data:*:*'
echo "show first 10 lines in ap_data"
ess stream ap_data '*' '*' 'head -10'
echo "loginf output for ap_data"
ess stream ap_data '*' '*' "loginf -test -f - -lim 1000 -o_pp_col -"
