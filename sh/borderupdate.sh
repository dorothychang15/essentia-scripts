#!/bin/sh
# processes newest border crossing data

ess cluster set local
ess select s3://asi-opendata --aws_access_key [[access key]] --aws_secret_access_key [[secret access key]]
ess category add borderupdate 'USTransportation/common/"Border Crossing Data"/*.csv' --overwrite
ess summary borderupdate
ess stream borderupdate '*' '*' 'aq_pp -f,+2,eok,qui,csv - -d s,trm:port i,trm:year  i,trm@13:bus  i,trm@14:personal i,trm@15:pedestrians -eval i:people "bus+personal+pedestrians" -mapf port "%%S1%%: %%S2%%" -mapc s:state "%%S1%%" -c year state people' > borderupdate.csv
