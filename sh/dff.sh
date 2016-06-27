#!/bin/sh
# effective daily federal funds rate for last 10 years

ess cluster set local
ess select s3://asi-opendata --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
ess category add dff 'FRED/DFF.csv' --dateregex=none --delimiter=',' --preprocess='aq_pp -f,+1,eok,qui,csv - -d s:date f:value -eval i:time "DateToTime(date, \"%Y.%m.%d\")"' --overwrite
ess summary dff
#example queries
echo "select everything and write to dff.csv"
ess query 'select * from dff:*:*' > dff.csv
echo "select 50 dates where value>5"
ess query 'select date,value from dff:*:* where value>5.0 limit 50'
echo "select dates after 2009-01-01 where value>5.0"
ess query 'select date,value from dff:*:* where time>1451649600 and value>5.0'
echo "select dates with 50 largest values"
ess query 'select date,value from dff:*:* order by value desc limit 50'
echo "select value for date 2009-01-01"
ess query 'select value from dff:*:* where date=="2009-01-01"'
