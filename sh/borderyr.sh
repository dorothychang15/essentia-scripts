#!/bin/sh
# processes border crossing data

ess cluster set local
ess select s3://asi-opendata --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
ess category add borderyr 'USTransportation/common/"Border Crossing Data"/417923300_T_BDRCROSS_COMBINED_FINAL*.zip' --dateregex='[:%Y:]' --preprocess='aq_pp -f,+1,csv,eok,qui - -d x: f:people x: x: x: x: x: x: x: x: x: x: x: x: x: x: s:border s:state x: x: x: i:year i:month -filt "people>0.0"' --overwrite
ess summary borderyr
ess query 'select year,state,people from bordercrossing:*:* where year==1995' >> borderyr.csv
ess query 'select year,state,people from bordercrossing:*:* where year==1996' >> borderyr.csv
ess query 'select year,state,people from bordercrossing:*:* where year==1997' >> borderyr.csv
ess query 'select year,state,people from bordercrossing:*:* where year==1998' >> borderyr.csv
ess query 'select year,state,people from bordercrossing:*:* where year==1999' >> borderyr.csv
ess query 'select year,state,people from bordercrossing:*:* where year==2000' >> borderyr.csv
ess query 'select year,state,people from bordercrossing:*:* where year==2001' >> borderyr.csv
ess query 'select year,state,people from bordercrossing:*:* where year==2002' >> borderyr.csv
ess query 'select year,state,people from bordercrossing:*:* where year==2003' >> borderyr.csv
ess query 'select year,state,people from bordercrossing:*:* where year==2004' >> borderyr.csv
ess query 'select year,state,people from bordercrossing:*:* where year==2005' >> borderyr.csv
ess query 'select year,state,people from bordercrossing:*:* where year==2006' >> borderyr.csv
ess query 'select year,state,people from bordercrossing:*:* where year==2007' >> borderyr.csv
